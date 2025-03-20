import 'package:flutter/material.dart';

import '../../core/widgets/circular_button.dart';
import '../../core/widgets/custom_icons.dart';

class CustomTextField extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onTap;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;

  const CustomTextField({
    super.key,
    this.padding,
    this.onTap,
    required this.controller,
    this.validator,
  });

  @override
  Size get preferredSize => Size(double.infinity, 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: "Adicionar Item",
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 5, right: 10, bottom: 5),
            child: CircularButton(
              onTap: onTap,
              padding: EdgeInsets.all(8),
              child: CustomIcon(icon: Icon(Icons.add)),
            ),
          ),
        ),
      ),
    );
  }
}
