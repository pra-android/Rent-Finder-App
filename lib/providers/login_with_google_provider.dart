import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rentfinderapp/providers/display_userdata_provider.dart';
import 'package:rentfinderapp/screens/home_screen.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(scopes: ['email']);
});

final authController = Provider<AuthController>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final googleSignIn = ref.watch(googleSignInProvider);
  final firebaseProvider = ref.watch(firebaseFirestoreProvider);
  return AuthController(auth, googleSignIn, firebaseProvider);
});

final loginGoogleLoading = StateProvider<bool>((ref) => false);

class AuthController {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firebaseFirestoreProvider;
  AuthController(this.auth, this.googleSignIn, this.firebaseFirestoreProvider);

  Future<User?> signInWithGoogle(WidgetRef ref) async {
    try {
      ref.read(loginGoogleLoading.notifier).state = true;
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final String email = googleUser.email;
      log("email is $email");
      final List<String> signInMethods = await auth.fetchSignInMethodsForEmail(
        email,
      );
      log(signInMethods.toString());
      if (signInMethods.contains('password')) {
        // Email is already linked with email/password provider
        Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg:
              "This email is already registered with email/password method.\nYou cannot use google method by same email",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        UserCredential userCredential = await auth.signInWithCredential(
          credential,
        );
        final User? user = ref.watch(currentUserProvider);
        if (user == null) {
          return null;
        }
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);
        DocumentSnapshot userSnapshot = await userDoc.get();
        String existingProfileImage =
            userSnapshot.exists
                ? userSnapshot.get('profileImage') ?? ''
                : googleUser.photoUrl ?? '';

        await firebaseFirestoreProvider
            .collection('users')
            .doc(auth.currentUser!.uid)
            .set({
              "userId": auth.currentUser!.uid,
              "userName": googleUser.displayName,
              "emailId": email,
              "phoneNumber": 'N/A',
              'profileImage':
                  existingProfileImage.isEmpty
                      ? user.photoURL ?? ''
                      : existingProfileImage,
            }, SetOptions(merge: true));

        Fluttertoast.showToast(
          msg: "Login Successful",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Get.offAll(() => HomeScreen()); // Navigate to Home Page after login
        return userCredential.user;
      }

      // Sign-in with Firebase
    } on FirebaseAuthException catch (e) {
      if (e.code == "network-request-failed") {
        String message;
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
        String message = e.toString();
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } finally {
      ref.read(loginGoogleLoading.notifier).state = false;
    }
  }
}
