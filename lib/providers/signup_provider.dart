import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/controller/signup_validation.dart';
import 'package:rentfinderapp/screens/home_screen.dart';

//Auth Provider
final authProvider = Provider((ref) {
  return FirebaseAuth.instance;
});
final firebaseFirestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});
final authControllerProvider = Provider<AuthController>((ref) {
  final auth = ref.watch(authProvider);
  final firebaseprovider = ref.watch(firebaseFirestoreProvider);
  return AuthController(auth, firebaseprovider);
});
var isLoading = StateProvider((ref) {
  return false;
});
final signUpKey = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

class AuthController {
  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestoreProvider;
  AuthController(this.auth, this.firebaseFirestoreProvider);
  Future<UserCredential?> signup(
    String email,
    String userName,
    String phoneNumber,
    String password,
    WidgetRef ref,
  ) async {
    try {
      ref.read(isLoading.notifier).state = true;
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firebaseFirestoreProvider
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({
            "userId": auth.currentUser!.uid,
            "userName": userName,
            "emailId": email,
            "phoneNumber": phoneNumber,
            'profileImage': '',
          });
      await Fluttertoast.showToast(
        msg: "Account Created Succesfully",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Get.to(() => HomeScreen());
      ref.read(emailController).clear();
      ref.read(userNameController).clear();
      ref.read(phoneNumberController).clear();
      ref.read(passwordController).clear();
      ref.read(confirmPasswordController).clear();
      return user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "network-request-failed") {
        message = e.toString();
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (e.code == "email-already-in-use") {
        message = "Email already in use";
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return null;
      }
    } finally {
      ref.read(isLoading.notifier).state = false;
    }
  }
}
