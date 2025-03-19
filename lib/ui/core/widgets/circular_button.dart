import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? width;
  final double? height;

  const CircularButton({
    super.key,
    this.onTap,
    this.child,
    this.padding,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color ?? Theme.of(context).primaryColor,
        ),
        child: child,
      ),
    );
  }
}
