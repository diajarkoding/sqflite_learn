import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_learn/app/data/db/db_note.dart';

import '../../../data/models/note_model.dart';

class HomeController extends GetxController {
  RxList allNote = <Note>[].obs;

  DbNote database = DbNote.instance;

  Future<void> fetchAllNote() async {
    Database db = await database.db;

    List<Map<String, dynamic>> data = await db.query("notes");

    if (data.isNotEmpty) {
      allNote(Note.toJsonList(data));
      allNote.refresh();
    } else {
      allNote.clear();
      allNote.refresh();
    }
  }

  Future<void> deleteNote(int id) async {
    Database db = await database.db;
    await db.delete(
      "notes",
      where: 'id = ?',
      whereArgs: [id],
    );

    fetchAllNote();
  }

  @override
  void onInit() {
    fetchAllNote();
    super.onInit();
  }
}
