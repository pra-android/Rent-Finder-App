import 'package:path/path.dart';
import 'package:rentfinderapp/model/favourites_rent.dart';
import 'package:sqflite/sqflite.dart';

class RentDatabaseHelper {
  static Database? _database;

  RentDatabaseHelper._();
  static final instance = RentDatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'rent_favourites.db');

    return openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favourites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageUrl TEXT NOT NULL,
            cityName TEXT NOT NULL,
            detailAddress TEXT  NOT NULL, 
            rentPrice TEXT NOT NULL,
            isFavorite INTEGER NOT NULL,
            rentId TEXT NOT NULL ,
            noofBeds INTEGER 
          )''');
      },
    );
  }

  Future<int> addToFavourites(RentModel model) async {
    final db = await database;
    int id = await db.insert('favourites', model.toMap());
    return id;
  }

  Future<void> removeFromFavorites(int id) async {
    final db = await database;
    await db.delete('favourites', where: 'id= ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(int? id) async {
    final db = await database;
    final result = await db.query(
      'favourites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<List<RentModel>> getFavourites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favourites');
    return List.generate(maps.length, (i) {
      return RentModel.fromMap(maps[i]);
    }).toList();
  }
}
