import 'package:get/get.dart';
import 'package:simple_notes_app/core/models/note.dart';

class NoteController extends GetxController {
  final _notes = RxList<Note>();

  RxList<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
  }
}