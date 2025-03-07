import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final changePhoneNoController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

//key for change phone no
final keyForChangePhoneNo = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final changePhoneNoLoading = StateProvider<bool>((ref) {
  return false;
});

final firestoreServiceProvider = Provider((ref) => FirestoreService());

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updatePhoneNumber(WidgetRef ref, String newPhone) async {
    try {
      ref.read(changePhoneNoLoading.notifier).state = true;
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'phoneNumber': newPhone,
        });
        Fluttertoast.showToast(msg: "Phone number changed successfully");
      }
    } catch (e) {
      throw Exception("Failed to update phone number: $e");
    } finally {
      ref.read(changePhoneNoLoading.notifier).state = false;
      ref.watch(changePhoneNoController).clear();
    }
  }
}
