import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const _DATA_BASE_NAME = "todos.db";
  static const _DATA_BASE_VERSION = 1;
  static const _TABLE = 'todos';
  static const COLUMN_ID = 'id';
  static const Title = "title";

  // make this a singleton class
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _DATA_BASE_NAME);
    return await openDatabase(path,
        version: _DATA_BASE_VERSION, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_TABLE (
            $COLUMN_ID TEXT PRIMARY KEY,
            $Title TEXT
          )
          ''');
  }


  // inserted row.
  Future<dynamic> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_TABLE, row);
  }

  
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(_TABLE);
  }

  Future<void> delete(String id) async {
    Database db = await instance.database;
   await db.delete("$_TABLE",where: '$COLUMN_ID = ?',whereArgs: [id]);
    
  }
}
