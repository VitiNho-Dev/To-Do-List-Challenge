import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
