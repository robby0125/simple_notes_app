import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/core/di/injection.dart';
import 'package:simple_notes_app/ui/utils/routes.dart';
import 'package:simple_notes_app/ui/utils/styles.dart';

void main() {
  Injection.provideInjection();
  runApp(const SimpleNotesApp());
}

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simple Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Styles.color.primaryColor,
        scaffoldBackgroundColor: Styles.color.backgroundColor,
        textTheme: Styles.textStyle.textTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: Styles.color.backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Styles.color.iconColor,
          ),
        ),
      ),
      getPages: Routes.getPages,
    );
  }
}
