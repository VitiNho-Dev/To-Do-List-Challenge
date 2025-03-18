import 'package:flutter/material.dart';

import 'circular_button.dart';

class CustomTextField extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onSubmitted;
  final EdgeInsetsGeometry? padding;

  const CustomTextField({super.key, this.onSubmitted, this.padding});

  @override
  Size get preferredSize => Size(double.infinity, 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextField(
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: "Add Item",
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 5, right: 10, bottom: 5),
            child: CircularButton(),
          ),
        ),
      ),
    );
  }
}
