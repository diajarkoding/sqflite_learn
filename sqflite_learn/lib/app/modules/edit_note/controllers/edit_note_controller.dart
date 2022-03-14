import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/db_note.dart';

class EditNoteController extends GetxController {
  RxBool isLoading = false.obs;

  DbNote database = DbNote.instance;

  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  Future<void> editNote(int id) async {
    Database db = await database.db;
    await db.update(
      "notes",
      {"id": id, "title": titleC.text, "desc": descC.text},
      where: "id = ?",
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
