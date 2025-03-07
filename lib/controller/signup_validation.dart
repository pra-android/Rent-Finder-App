import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

//login
final loginPasswordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final loginEmailController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

//signup
final userNameController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final emailController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final phoneNumberController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final passwordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final confirmPasswordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

class SignupValidation {
  static String? userNameValidation(String name) {
    return name.isEmpty ? "Required" : null;
  }

  static String? emailValidation(String email) {
    return GetUtils.isEmail(email) ? null : "Invalid Email";
  }

  static String? phoneNumberValidation(String phoneNumber) {
    return phoneNumber.length == 10 ? null : "Invalid Phone number";
  }

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
