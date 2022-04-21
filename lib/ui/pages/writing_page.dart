import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/core/controllers/note_controller.dart';
import 'package:simple_notes_app/core/models/note.dart';
import 'package:simple_notes_app/ui/utils/styles.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _noteController = Get.find<NoteController>();

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _contentController.dispose();
  }

  bool isContentFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: isContentFilled ? _saveNote : null,
            icon: Icon(
              FontAwesomeIcons.check,
              color: isContentFilled
                  ? Styles.color.iconColor
                  : Colors.grey.shade300,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: Styles.dimen.appMargin,
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: Get.textTheme.headline6,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: Get.textTheme.headline6!.copyWith(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                autofocus: true,
                maxLines: null,
                style: Get.textTheme.bodyText1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {
                  isContentFilled = value.isNotEmpty;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    final _title = _titleController.text.toString().trim();
    final _content = _contentController.text.toString().trim();

    final _note = Note(title: _title, content: _content);

    _noteController.addNote(_note);

    Get.back();
  }
}
