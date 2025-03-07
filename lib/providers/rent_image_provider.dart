import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, AsyncValue<String?>>(
      (ref) => ImageUploadNotifier(),
    );

class ImageUploadNotifier extends StateNotifier<AsyncValue<String?>> {
  ImageUploadNotifier() : super(const AsyncData(null));

  final ImagePicker _picker = ImagePicker();

  Future<void> pickAndUploadRentImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return; // User canceled selection

      File imageFile = File(pickedFile.path);
      state = const AsyncLoading();
      String imageUrl = await uploadImageToCloudinary(imageFile);

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
