import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentfinderapp/controller/change_password_validation.dart';
import 'package:rentfinderapp/providers/login_provider.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final changePasswordLoading = StateProvider<bool>((ref) {
  return false;
});

final authControllerChangePassword = Provider((ref) {
  return AuthControllerChangePassword(ref.watch(firebaseAuthProvider));
});

class AuthControllerChangePassword {
  final FirebaseAuth auth;
  AuthControllerChangePassword(this.auth);

  Future<void> changePassword(
    WidgetRef ref,
    String currentPassword,
    String newPassword,
  ) async {
    try {
      ref.read(changePasswordLoading.notifier).state = true;
      final auth = ref.read(firebaseAuthProvider);
      final user = auth.currentUser;
      if (user == null) {
        Fluttertoast.showToast(msg: "User not found! Please log in again.");
        return;
      }
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: "Password Changed Sucessfully",
      );
      await ref.watch(authControllerProvider).signOut(ref);
    } catch (e) {
      log("Error updating password: $e");
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: "$e",
      );
    } finally {
      ref.read(changePasswordLoading.notifier).state = false;
      ref.watch(currentPasswordController).clear();
      ref.watch(changePasswordController).clear();
      ref.watch(changePasswordConfirmController).clear();
    }
  }
}
