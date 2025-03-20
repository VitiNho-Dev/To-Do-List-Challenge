import 'package:flutter/material.dart';

import '../../../utils/format_date.dart';
import '../themes/app_colors.dart';

class CardItem extends StatelessWidget {
  final String title;
  final bool lineThrough;
  final Widget icon;
  final DateTime? dueDate;
  final double? elevation;
  final Color? color;
  final void Function()? onTap;

  const CardItem({
    super.key,
    required this.title,
    required this.icon,
    this.dueDate,
    this.elevation,
    this.color,
    this.onTap,
    this.lineThrough = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final appColor = AppColors.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  spacing: 16,
                  children: [
                    icon,
                    Expanded(
                      child: Text(
                        title,
                        style:
                            !lineThrough
                                ? textStyle.bodyLarge
                                : textStyle.bodyLarge!.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              if (dueDate != null)
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: appColor.accent,
                    ),
                    Text(formatDate(dueDate), style: textStyle.bodySmall),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
