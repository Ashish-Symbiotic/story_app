
import 'dart:async';


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class Payment_db_service{
  static final  Payment_db_service pay_db_service = Payment_db_service._internal();
  factory Payment_db_service() => pay_db_service;

  Payment_db_service._internal();

  static Database? _db;

  Future<Database> get database async {
  if(_db!=null) return _db!;
  _db = await  _initDB();
  return _db!;
}

  Future<Database> _initDB() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath,"flutter_sqflite_database.db");


  return await openDatabase(path, onCreate: _onCreate, version: 1 );
}


  FutureOr<void> _onCreate(Database db, int version) {
  db.execute("Create table payment_info("
      "id INTEGER PRIMARY KEY, "
      "name TEXT,"
      "total INTEGER,"
      "txn_amt INTEGER,"
      "bal INTEGER,"
      "type TEXT, "
      "desc TEXT,"
      "date TEXT");

  }

Future<void> saveNewInfo() async{

}
}