import 'package:flutter/material.dart';

void showResultDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Result'),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

void scanningDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.black87,
      title: const Text(
        'Scanning NFC...',
        style: TextStyle(color: Colors.white),
      ),
      content: const LinearProgressIndicator(
        color: Colors.deepPurple,
      ),
    ),
  );
}
