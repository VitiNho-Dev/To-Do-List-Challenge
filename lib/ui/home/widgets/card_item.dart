import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/format_date.dart';

class CardItem extends StatelessWidget {
  final Text title;
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
  });

  @override
  Widget build(BuildContext context) {
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
                  children: [icon, Expanded(child: title)],
                ),
              ),
              if (dueDate != null)
                Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.calendar_month),
                    Text(formatDate(dueDate)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
