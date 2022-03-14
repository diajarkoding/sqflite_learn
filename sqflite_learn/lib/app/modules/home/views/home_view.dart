import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sqflite_learn/app/routes/app_pages.dart';

import '../../../data/models/note_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchAllNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Obx(
            () => (controller.allNote.isEmpty)
                ? const Center(
                    child: Text('Tidak ada data'),
                  )
                : ListView.builder(
                    itemCount: controller.allNote.length,
                    itemBuilder: (context, index) {
                      Note note = controller.allNote[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            '${note.id}',
                          ),
                        ),
                        title: Text(
                          '${note.title}',
                        ),
                        subtitle: Text(
                          '${note.desc}',
                        ),
                        trailing: IconButton(
                          onPressed: () => controller.deleteNote(note.id!),
                          icon: const Icon(Icons.delete),
                        ),
                        onTap: () =>
                            Get.toNamed(Routes.EDIT_NOTE, arguments: note),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_NOTE),
        child: const Icon(Icons.add),
      ),
    );
  }
}
