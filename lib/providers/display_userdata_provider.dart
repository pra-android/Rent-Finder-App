import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentfinderapp/providers/login_provider.dart';

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateChangesProvider).value;
});

final userDataProvider = StreamProvider.autoDispose<Map<String, dynamic>?>((
  ref,
) {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return Stream.value(null);
  } else {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }
});
