import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Icon icon;
  final IconThemeData? iconThemeData;

  const CustomIcon({super.key, required this.icon, this.iconThemeData});

  @override
  Widget build(BuildContext context) {
    final iconThemeData = Theme.of(context).iconTheme;

    return IconTheme(data: this.iconThemeData ?? iconThemeData, child: icon);
  }
}
