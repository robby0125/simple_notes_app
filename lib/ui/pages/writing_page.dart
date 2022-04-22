import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/core/controllers/note_controller.dart';
import 'package:simple_notes_app/ui/dialogs/confirmation_dialog.dart';
import 'package:simple_notes_app/ui/utils/styles.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({
    Key? key,
    this.editedNoteUid,
  }) : super(key: key);

  final String? editedNoteUid;

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _noteController = Get.find<NoteController>();

  @override
  void initState() {
    super.initState();

    if (widget.editedNoteUid != null) {
      final _editedNote = _noteController.getNoteByUid(widget.editedNoteUid!);

      _titleController.text = _editedNote.title ?? '';
      _contentController.text = _editedNote.content;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _contentController.dispose();
  }

  bool isContentFilled = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.editedNoteUid != null) {
          return _checkChanges();
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: _buildAppBarActions(),
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
                  onChanged: (value) {
                    final _newValue = value.isNotEmpty;

                    if (_newValue != isContentFilled) {
                      setState(() {
                        isContentFilled = value.isNotEmpty;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    final _title = _titleController.text.toString().trim();
    final _content = _contentController.text.toString().trim();

    if (widget.editedNoteUid == null) {
      _noteController.addNote(
        content: _content,
        title: _title.isNotEmpty ? _title : null,
      );
    } else {
      _noteController.updateNote(
        uid: widget.editedNoteUid!,
        content: _content,
        title: _title.isNotEmpty ? _title : null,
      );
    }

    Get.back();
  }

  void _deleteNote() {
    showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: 'Delete Note',
        message: 'Are you sure you want to delete this note?',
        positiveCallback: () {
          _noteController.deleteNote(uid: widget.editedNoteUid!);
          Get.close(2);
        },
      ),
    );
  }

  bool _checkChanges() {
    if (widget.editedNoteUid == null) return true;

    final _title = _titleController.text.toString().trim();
    final _content = _contentController.text.toString().trim();

    final _editedNote = _noteController.getNoteByUid(widget.editedNoteUid!);

    bool _hasChange = _editedNote.content != _content;

    if (_title.isNotEmpty) {
      _hasChange = _hasChange || _editedNote.title != _title;
    }

    if (_hasChange) {
      showDialog(
        context: context,
        builder: (_) => ConfirmationDialog(
          title: 'Save Changes',
          message: 'Do you want to save changes?',
          positiveCallback: () {
            _noteController.updateNote(
              uid: widget.editedNoteUid!,
              content: _content,
              title: _title.isNotEmpty ? _title : null,
            );

            Get.close(2);
          },
          negativeCallback: () => Get.close(2),
        ),
      );

      return false;
    }

    return true;
  }

  List<Widget> _buildAppBarActions() {
    List<Widget> _actions = [];

    if (widget.editedNoteUid != null) {
      _actions.add(
        IconButton(
          onPressed: _deleteNote,
          icon: Icon(
            FontAwesomeIcons.trash,
            color: Styles.color.iconColor,
          ),
        ),
      );
    }

    _actions.add(
      IconButton(
        onPressed: isContentFilled ? _saveChanges : null,
        icon: Icon(
          FontAwesomeIcons.check,
          color:
              isContentFilled ? Styles.color.iconColor : Colors.grey.shade300,
        ),
      ),
    );

    return _actions;
  }
}
