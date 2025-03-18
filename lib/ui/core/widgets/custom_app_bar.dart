import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/core/themes/colors.dart';

import 'custom_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;

  const CustomAppBar({super.key, this.bottom});

  @override
  Size get preferredSize => Size(double.infinity, 120);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      bottom: bottom,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomIcon(
          icon: Icon(Icons.dehaze_sharp, size: 36),
          iconThemeData: theme.iconTheme.copyWith(
            color:
                theme.brightness == Brightness.dark
                    ? AppColorsDark.darkBlue5
                    : AppColorsDark.darkBlue3,
          ),
        ),
      ),
    );
  }
}
