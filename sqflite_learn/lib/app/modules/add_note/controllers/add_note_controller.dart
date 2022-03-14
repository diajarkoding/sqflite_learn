import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_learn/app/data/db/db_note.dart';

class AddNoteController extends GetxController {
  DbNote database = DbNote.instance;

  RxBool isLoading = false.obs;

  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  void addNote() async {
    isLoading.value = true;

    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      Database db = await database.db;

      await db.insert(
        "notes",
        {"title": titleC.text, "desc": descC.text},
      );
    }
    isLoading.value = false;
    Get.back();
  }
}
