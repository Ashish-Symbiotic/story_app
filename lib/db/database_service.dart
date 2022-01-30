import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:story_app/models/note.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.

    final path = join(databasePath, 'flutter_sqflite_database.db');
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY,title TEXT, desc TEXT)');
  }

  Future<void> insertNote(Notes notes) async {
    final db = await _databaseService.database;
      //

    await db.insert('notes', notes.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Notes>> notes() async {
    final db = await _databaseService.database;

    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (index) => Notes.fromMap(maps[index]));
  }
  void insert() {
    //final db = await _databaseService.database;
    insertNote(Notes(title:"Ashish",desc: "Qwerty"));

    print("Hello");
  }
}
