import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sqflite_learn/app/modules/home/controllers/home_controller.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  AddNoteView({Key? key}) : super(key: key);

  final HomeController homeC = Get.find();

  @override
  Widget build(BuildContext context) {
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
              controller.addNote();
              homeC.fetchAllNote();
              Get.back();
            }
          },
          child:
              Text(controller.isLoading.isFalse ? 'Add Note' : 'loading ...'),
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
