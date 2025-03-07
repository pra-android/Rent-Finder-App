import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final imageUploadProvider =
    StateNotifierProvider.autoDispose<ImageUploadNotifier, AsyncValue<String?>>(
      (ref) => ImageUploadNotifier(),
    );

class ImageUploadNotifier extends StateNotifier<AsyncValue<String?>> {
  ImageUploadNotifier() : super(const AsyncData(null)) {
    _loadProfileImage();
  }
  Future<void> _loadProfileImage() async {
    try {
      String uid = _auth.currentUser?.uid ?? "";
      if (uid.isEmpty) return;

      // Fetch profile image URL from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      String? imageUrl = userDoc['profileImage'] as String?;
      state = AsyncData(imageUrl);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> pickAndUploadImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return; // User canceled selection

      File imageFile = File(pickedFile.path);
      state = const AsyncLoading();
      String imageUrl = await uploadImageToCloudinary(imageFile);

      // Save the image URL to Firestore
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'profileImage': imageUrl,
      });

      state = AsyncData(imageUrl);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<String> uploadImageToCloudinary(File imageFile) async {
    final cloudName = "dvqlshrm4";
    final uploadPreset = "rentfinder";

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload"),
    );

    request.fields['upload_preset'] = uploadPreset;
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseData);

    if (response.statusCode == 200) {
      return jsonResponse['secure_url'];
    } else {
      throw Exception("Failed to upload image: ${jsonResponse['error']}");
    }
  }
}
