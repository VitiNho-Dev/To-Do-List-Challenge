import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Text title;
  final Widget icon;
  final String? dueDate;
  final double? elevation;
  final Color? color;

  const CardItem({
    super.key,
    required this.title,
    required this.icon,
    this.dueDate,
    this.elevation,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Row(spacing: 16, children: [icon, Expanded(child: title)]),
            ),
            if (dueDate != null)
              Row(children: [Icon(Icons.calendar_month), Text(dueDate!)]),
          ],
        ),
      ),
    );
  }
}
