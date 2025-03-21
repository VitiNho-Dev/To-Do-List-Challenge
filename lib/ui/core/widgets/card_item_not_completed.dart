import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import 'card_item.dart';
import 'circular_button.dart';

class CardItemNotCompleted extends StatelessWidget {
  final String title;
  final DateTime? dueDate;
  final void Function()? onTap;
  final void Function()? onTapIcon;
  final void Function()? onLongPress;

  const CardItemNotCompleted({
    super.key,
    required this.title,
    this.dueDate,
    this.onTap,
    this.onTapIcon,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.of(context);

    return CardItem(
      title: title,
      color: color.cardNotCompleted,
      dueDate: dueDate,
      onTap: onTap,
      onLongPress: onLongPress,
      icon: CircularButton(
        onTap: onTapIcon,
        height: 28,
        width: 28,
        color: color.white,
        borderColor: color.borderIcon,
      ),
    );
  }
}
