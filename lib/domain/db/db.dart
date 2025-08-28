import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider();

  Future<Database> get database async {
    if (_database != null) return _database!;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "cards.db");

    _database = await openDatabase(path, version: 1, onCreate: _initDB);

    return _database!;
  }

  Future _initDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Cards (
        id INTEGER PRIMARY KEY,
        name TEXT,
        status TEXT,
        species TEXT,
        gender TEXT,
        image TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Favorites (
        id INTEGER PRIMARY KEY,
        name TEXT,
        status TEXT,
        species TEXT,
        gender TEXT,
        image TEXT
      )
    ''');
  }

  Future<void> insertCards(List<CardModel> cards) async {
    final db = await DBProvider.db.database;

    Batch batch = db.batch();
    for (var card in cards) {
      batch.insert('Cards', card.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<CardModel>> getCards() async {
    final db = await DBProvider.db.database;
    final res = await db.query('Cards');
    return res.map((e) => CardModel.fromMap(e)).toList();
  }

  Future<void> addToFavorites(CardModel card) async {
    final db = await database;
    await db.insert('Favorites', card.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFromFavorites(int id) async {
    final db = await database;
    await db.delete('Favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<CardModel>> getFavorites() async {
    final db = await database;
    final res = await db.query('Favorites');
    return res.map((e) => CardModel.fromMap(e)).toList();
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final res = await db.query('Favorites', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty;
  }
}
