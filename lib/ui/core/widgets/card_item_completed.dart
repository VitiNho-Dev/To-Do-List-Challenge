import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import 'card_item.dart';
import 'circular_button.dart';

class CardItemCompleted extends StatelessWidget {
  final String title;
  final bool lineThrough;
  final DateTime? dueDate;
  final void Function()? onTap;
  final void Function()? onTapIcon;

  const CardItemCompleted({
    super.key,
    required this.title,
    this.lineThrough = false,
    this.dueDate,
    this.onTap,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.of(context);

    return CardItem(
      title: title,
      lineThrough: lineThrough,
      elevation: 0,
      color: color.cardCompleted,
      dueDate: dueDate,
      onTap: onTap,
      icon: CircularButton(
        onTap: onTapIcon,
        height: 28,
        width: 28,
        padding: EdgeInsets.zero,
        color: color.lightGreen,
        child: Icon(Icons.check, color: color.success),
      ),
    );
  }
}
