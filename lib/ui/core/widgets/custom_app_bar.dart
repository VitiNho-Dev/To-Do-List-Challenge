import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({super.key, this.bottom, this.leading});

  @override
  Size get preferredSize => Size(double.infinity, bottom != null ? 120 : 50);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.of(context);

    return Container(
      decoration: BoxDecoration(
        color: color.background,
        boxShadow: [
          BoxShadow(
            color: color.accent.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(bottom: bottom, leading: leading),
    );
  }
}
