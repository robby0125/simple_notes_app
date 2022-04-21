import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/core/controllers/note_controller.dart';
import 'package:simple_notes_app/ui/utils/styles.dart';
import 'package:simple_notes_app/ui/widgets/add_note_card.dart';
import 'package:simple_notes_app/ui/widgets/note_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: Get.textTheme.headline5!.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.color.primaryColor,
          ),
        ),
      ),
      body: Obx(() {
        final _notes = _noteController.notes;

        return GridView.builder(
          padding: Styles.dimen.appMargin,
          clipBehavior: Clip.none,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
          ),
          itemCount: _notes.length + 1,
          itemBuilder: (_, index) {
            return index == 0
                ? const AddNoteCard()
                : NoteCard(note: _notes[index - 1]);
          },
        );
      }),
    );
  }
}
