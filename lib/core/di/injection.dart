import 'package:get/get.dart';
import 'package:simple_notes_app/core/controllers/note_controller.dart';

class Injection {
  static void provideInjection() {
    Get.put(NoteController());
  }
}