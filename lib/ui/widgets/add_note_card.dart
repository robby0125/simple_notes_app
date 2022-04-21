import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_notes_app/ui/utils/routes.dart';
import 'package:simple_notes_app/ui/utils/styles.dart';

class AddNoteCard extends StatelessWidget {
  const AddNoteCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Styles.color.primaryColor,
      child: InkWell(
        onTap: () => Get.toNamed(Routes.writing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Icon(
                FontAwesomeIcons.plus,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Add Note',
              style: Get.textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
