import 'package:get/get.dart';
import 'package:simple_notes_app/ui/pages/home_page.dart';
import 'package:simple_notes_app/ui/pages/writing_page.dart';

class Routes {
  static const String home = '/';
  static const String writing = '/writing';

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(
      name: writing,
      page: () => WritingPage(editedNoteUid: Get.arguments),
    ),
  ];
}
