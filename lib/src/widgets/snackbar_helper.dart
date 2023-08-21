import 'package:flutter/material.dart';

enum SnackBarType {
  info,
  error,
}

class SnackBarHelper {
  static void showSnackBar(BuildContext context, String message, SnackBarType type, {Duration duration = const Duration(seconds: 2)}) {
    Color backgroundColor;
    switch (type) {
      case SnackBarType.info:
        backgroundColor = Colors.green;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        break;
    }

    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: duration,
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
