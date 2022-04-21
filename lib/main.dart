import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/ui/utils/routes.dart';

void main() => runApp(const SimpleNotesApp());

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simple Notes App',
      getPages: Routes.getPages,
    );
  }
}
