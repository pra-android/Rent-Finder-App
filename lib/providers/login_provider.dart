import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rentfinderapp/controller/signup_validation.dart';
import 'package:rentfinderapp/providers/display_userdata_provider.dart';
import 'package:rentfinderapp/providers/login_with_google_provider.dart';
import 'package:rentfinderapp/screens/home_screen.dart';
import 'package:rentfinderapp/screens/onboardingscreen/onboarding_screen.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
final authControllerProvider = Provider<AuthController>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthController(auth);
});
final logInKey = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final loginLoading = StateProvider((ref) => false);
final hidePassword = StateProvider((ref) => true);

class AuthController {
  final FirebaseAuth auth;
  AuthController(this.auth);
  Future<User?> loginWithEmail(
    WidgetRef ref,
    String email,
    String password,
  ) async {
    try {
      ref.read(loginLoading.notifier).state = true;
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
      log("Sign in methods are $signInMethods");
      if (signInMethods.isNotEmpty &&
          signInMethods.first.toLowerCase() == 'google.com') {
        // Show alert

        Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
          msg:
              'This email is registered with another sign-in method. Please use the Google sign in  method to log in.',
        );

        ref.read(loginLoading.notifier).state = false;
        return null;
      } else {
        ref.read(loginLoading.notifier).state = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        ref.invalidate(currentUserProvider);
        ref.invalidate(userDataProvider);
        Fluttertoast.showToast(
          msg: "Login Succesfull",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Get.offAll(() => HomeScreen());
        ref.read(loginEmailController).clear();
        ref.read(loginPasswordController).clear();
        return userCredential.user;
      }
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
      } else {
        Fluttertoast.showToast(
          msg: "Incorrect Email/Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      return null;
    } finally {
      ref.read(loginLoading.notifier).state = false;
      ref.read(loginEmailController).clear();
      ref.read(loginPasswordController).clear();
    }
  }

  //logout
  Future<void> signOut(WidgetRef ref) async {
    try {
      final googleSignIn = ref.read(googleSignInProvider);
      ref.read(loginEmailController).clear();
      ref.read(loginPasswordController).clear();

      await Future.wait([
        FirebaseAuth.instance.signOut(),
        googleSignIn.signOut(),
      ]);

      Fluttertoast.showToast(
        msg: "Successfully Logged Out",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.offAll(() => const OnboardingScreen());
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Logout Failed: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
