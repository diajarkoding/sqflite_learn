import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/note_model.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  EditNoteView({Key? key}) : super(key: key);

  Note note = Get.arguments;

  final HomeController homeC = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.titleC.text = note.title!;
    controller.descC.text = note.desc!;

    Widget titleTextField() {
      return TextField(
        controller: controller.titleC,
        decoration: const InputDecoration(
            labelText: "title", border: OutlineInputBorder()),
      );
    }

    Widget descTextField() {
      return TextField(
        controller: controller.descC,
        decoration: const InputDecoration(
            labelText: "desc", border: OutlineInputBorder()),
      );
    }

    Widget addNoteButton() {
      return Obx(
        () => ElevatedButton(
          onPressed: () {
            if (controller.isLoading.isFalse) {
              controller.editNote(note.id!);
              homeC.fetchAllNote();
              Get.back();
            }
          },
          child:
              Text(controller.isLoading.isFalse ? 'Edit Note' : 'loading ...'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          titleTextField(),
          const SizedBox(
            height: 20,
          ),
          descTextField(),
          const SizedBox(
            height: 20,
          ),
          addNoteButton()
        ],
      ),
    );
  }
}
