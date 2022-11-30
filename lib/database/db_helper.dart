import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/simpe_recipe_db.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();

  DbHelper._internal();
  factory DbHelper() => _instance;
  static Database? database;
  final String tableName = 'resep';
  final String id = 'id';
  final String disImage = 'disimage';
  final String title = 'title';
  final String duration = 'duration';
  final String source = 'source';
  final String information = 'information';

  Future<Database?> get _db async {
    if (database != null) {
      return database!;
    } else {
      database = await _initDb();
      return database!;
    }
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath + 'fooderlich.db');
    // return await openDatabase(path, version: 1, 
    // onCreate: _onCreate(path, 1));
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = 'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, '
        '$disImage TEXT, $title TEXT, $duration TEXT, $source TEXT, '
        '$information TEXT)';
    await db.execute(sql);
  }
  Future<int> addResep(SimpleRecipeDb recipe) async {
    var dbClient = await _db;
    var result = await dbClient!.insert(tableName, recipe.toMap());
    return result;
  }
}
