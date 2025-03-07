import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentfinderapp/providers/location_tracker_provider.dart';
import 'package:rentfinderapp/providers/rent_image_provider.dart';

final sellerName = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final sellerPhoneNumber = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final cityName = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final detailAddress = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final noOfBeds = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final rentPrice = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});
final rentPostingLoading = StateProvider<bool>((ref) {
  return false;
});

//post rent key
final postRentKey = Provider<GlobalKey<FormState>>(
  (ref) => GlobalKey<FormState>(),
);

final rentInformationProvider =
    StateNotifierProvider<RentInformationNotifier, Map<String, String>>((ref) {
      return RentInformationNotifier(ref.watch(firestoreProvider));
    });

class RentInformationNotifier extends StateNotifier<Map<String, String>> {
  final FirebaseFirestore _firestore;

  RentInformationNotifier(this._firestore) : super({});

  // Function to add rent info to Firestore
  Future<void> postRentInformation({
    required String rentImage,
    required String sellername,
    required String sellerphoneNumber,
    required String cityname,
    required double latitude,
    required double longitude,
    required String detailaddress,
    required String noofBeds,
    required String category,
    required String rentprice,
    required WidgetRef ref,
  }) async {
    try {
      ref.read(rentPostingLoading.notifier).state = true;

      DocumentReference documentReference = await _firestore
          .collection('rents')
          .add({
            'rentImage': rentImage,
            'sellerName': sellername,
            'sellerPhoneNumber': sellerphoneNumber,
            'latitude': latitude,
            'longitude': longitude,
            'cityName': cityname,
            'detailAddress': detailaddress,
            'noOfBeds': noofBeds,
            'category': category,
            'rentPrice': rentprice,
            'createdAt': FieldValue.serverTimestamp(),
          });
      String rentId = documentReference.id;
      await documentReference.update({'rentId': rentId});

      Fluttertoast.showToast(msg: "Rent information posted succesfully");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      ref.read(rentPostingLoading.notifier).state = false;
      ref.watch(sellerName).clear();
      ref.watch(sellerPhoneNumber).clear();
      ref.watch(cityName).clear();
      ref.watch(detailAddress).clear();
      ref.watch(noOfBeds).clear();
      ref.watch(rentPrice).clear();
      ref.read(selectedLocationProvider.notifier).state = null;
      ref.read(imageUploadProvider.notifier).state = AsyncData(null);
    }
  }
}
