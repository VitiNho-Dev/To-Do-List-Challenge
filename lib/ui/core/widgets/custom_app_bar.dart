import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({super.key, this.bottom, this.leading});

  @override
  Size get preferredSize => Size(double.infinity, bottom != null ? 120 : 50);

  @override
  Widget build(BuildContext context) {
    return AppBar(bottom: bottom, leading: leading);
  }
}
