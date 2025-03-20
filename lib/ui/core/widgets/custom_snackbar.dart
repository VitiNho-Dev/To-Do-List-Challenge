import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context, {required String message}) {
    final textStyle = Theme.of(context).textTheme;
    final appColor = AppColors.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle.bodyLarge!.copyWith(color: appColor.white),
        ),
      ),
    );
  }
}
