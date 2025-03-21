import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CustomAlertDialog {
  static void showAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
    required Function() onTap,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final color = AppColors.of(context);
        final textTheme = Theme.of(context).textTheme;

        return AlertDialog(
          backgroundColor: color.background,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          content: Text(
            content,
            style: textTheme.bodySmall!.copyWith(color: color.textColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar', style: TextStyle(color: color.error)),
            ),
            TextButton(
              onPressed: onTap,
              child: Text('Confirmar', style: TextStyle(color: color.success)),
            ),
          ],
        );
      },
    );
  }
}
