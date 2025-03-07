import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rentStreamProvider = StreamProvider.autoDispose((ref) {
  final selectedIndex = ref.watch(categoryIndex);
  final categories = ['Single Room', 'Whole Flat', 'House', 'Hostel/PG'];
  final selectedCategory = categories[selectedIndex];
  return FirebaseFirestore.instance
      .collection('rents')
      .where('category', isEqualTo: selectedCategory)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
});

final categoryIndex = StateProvider<int>((ref) {
  return 0;
});
