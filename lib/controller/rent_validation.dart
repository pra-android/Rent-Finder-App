import 'package:flutter_riverpod/flutter_riverpod.dart';

final submittedStatus = StateProvider<bool>((ref) {
  return false;
});

class RentValidation {
  static String? validateSellerName(String name) {
    return name.isEmpty ? "Required" : null;
  }

  static String? validateSellerPhoneNumber(String number) {
    return number.length == 10 ? null : "Invalid phone number";
  }

  static String? validatecityName(String cityName) {
    return cityName.isEmpty ? "Required" : null;
  }

  static String? validatedetailAddress(String deaddress) {
    return deaddress.isEmpty ? "Required" : null;
  }

  static String? validateNoOfBeds(String nob) {
    if (nob.isEmpty) {
      return "Can't be empty";
    }
    final parsedValue = int.tryParse(nob);
    if (parsedValue == null) {
      return "Enter a valid number";
    }
    if (parsedValue < 0) {
      return "Number can't be negative";
    }
    return null; // Valid input
  }

  static String? validateRentPrice(String nob) {
    if (nob.isEmpty) {
      return "Can't be empty";
    }
    final parsedValue = int.tryParse(nob);
    if (parsedValue == null) {
      return "Enter a valid number ";
    }
    if (parsedValue < 0) {
      return "Number  can't be negative";
    }
    return null; // Valid input
  }
}
