import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbNote {
  // private constructor
  DbNote._privateConstructor();
  static DbNote instance = DbNote._privateConstructor();

  // variabel database
  Database? _db;

  // getter database
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
      return _db!;
    } else {
      return _db!;
    }
  }

  Future _initDb() async {
    // membuat table database
    Directory documentDirerctory = await getApplicationDocumentsDirectory();

    String path = join(documentDirerctory.path, "note.db");

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      return await database.execute(
        '''
          CREATE TABLE notes (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          desc TEXT NOT NULL
          )
      ''',
      );
    });
  }

  Future closeDb() async {
    _db = await instance.db;
    _db!.close();
  }
}
