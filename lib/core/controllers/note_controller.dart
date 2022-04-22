import 'package:get/get.dart';
import 'package:simple_notes_app/core/models/note.dart';
import 'package:uuid/uuid.dart';

class NoteController extends GetxController {
  final _notes = RxList<Note>();
  final _uuid = const Uuid();

  RxList<Note> get notes => _notes;

  void addNote({
    String? title,
    required String content,
  }) {
    final _newUid = _uuid.v1();
    final _newNote = Note(
      uid: _newUid,
      content: content,
      title: title,
    );

    _notes.add(_newNote);
  }

  void updateNote({
    required String uid,
    required String content,
    String? title,
  }) {
    final _edtIndex = _notes.indexWhere((note) => note.uid == uid);
    final _newNote = Note(
      uid: uid,
      content: content,
      title: title,
    );

    _notes[_edtIndex] = _newNote;
  }

  void deleteNote({required String uid}) {
    _notes.removeWhere((note) => note.uid == uid);
  }

  Note getNoteByUid(String uid) => _notes.firstWhere((note) => note.uid == uid);
}
