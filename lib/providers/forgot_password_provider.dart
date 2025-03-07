import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
//key
final forgotPasswordKey = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

//loading
final forgotPasswordLoading = StateProvider<bool>((ref) {
  return false;
});

final forgotPasswordController = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
