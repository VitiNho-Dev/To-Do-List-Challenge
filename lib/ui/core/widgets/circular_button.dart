import 'package:flutter/material.dart';

import 'custom_icons.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).primaryColor,
      ),
      child: CustomIcon(icon: Icon(Icons.add)),
    );
  }
}
