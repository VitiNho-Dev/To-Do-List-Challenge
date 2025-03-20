import 'package:flutter/material.dart';

import '../themes/colors.dart';

class CircularButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final double? width;
  final double? height;

  const CircularButton({
    super.key,
    this.onTap,
    this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.width,
    this.height,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final appColor = AppColors.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? appColor.primary,
          borderRadius: BorderRadius.circular(100),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: child,
      ),
    );
  }
}
