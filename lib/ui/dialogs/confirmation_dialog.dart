import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.positiveCallback,
    this.negativeCallback,
  }) : super(key: key);

  final String title;
  final String message;
  final VoidCallback positiveCallback;
  final VoidCallback? negativeCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            if (negativeCallback != null) {
              negativeCallback!();
              return;
            }

            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: positiveCallback,
          child: const Text('Yes'),
        )
      ],
    );
  }
}
