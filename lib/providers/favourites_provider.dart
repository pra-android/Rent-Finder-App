import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentfinderapp/database/rent_database.dart';
import '../model/favourites_rent.dart';

final favouritesProvider =
    StateNotifierProvider<FavouritesProvider, List<RentModel>>((ref) {
      return FavouritesProvider();
    });

class FavouritesProvider extends StateNotifier<List<RentModel>> {
  FavouritesProvider() : super([]) {
    loadFavourites();
  }

  final dbHelper = RentDatabaseHelper.instance;

  Future<void> loadFavourites() async {
    final favourites = await dbHelper.getFavourites();
    state = favourites;
  }

  Future<void> addingFavourites(RentModel rent) async {
    final dbId = await dbHelper.addToFavourites(rent);
    final newModel = rent.copyWith(id: dbId);
    state = [...state, newModel];
    log("The adding data with id is $dbId");
    Fluttertoast.showToast(
      msg: "Added to Favourties",
      gravity: ToastGravity.TOP,
    );
  }

  void removeFromFavourites(int id) async {
    await dbHelper.removeFromFavorites(id);
    state = state.where((item) => item.id != id).toList();
    log("Removed data with id: $id");
    Fluttertoast.showToast(
      msg: "Remove From Favourites",
      gravity: ToastGravity.TOP,
    );
  }
}
