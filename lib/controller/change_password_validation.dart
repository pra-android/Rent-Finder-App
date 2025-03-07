import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPasswordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final changePasswordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final changePasswordConfirmController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

//key
final keyForChangePassword = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final passwordStatus1 = StateProvider((ref) {
  return true;
});
final passwordStatus2 = StateProvider((ref) {
  return true;
});

final passwordStatus3 = StateProvider((ref) {
  return true;
});

class ChangePasswordValidation {
  static String? passwordValidation(String password) {
    return password.length > 5
        ? null
        : "Password must be of greater than 5 characters";
  }

  static String? confirmPasswordValidation(
    String password,
    String confirmPassword,
  ) {
    return password == confirmPassword ? null : "Password does not match";
  }
}
