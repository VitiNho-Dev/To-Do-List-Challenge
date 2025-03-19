import 'package:flutter/material.dart';

class ContentTopicWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const ContentTopicWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [Text(title), child],
    );
  }
}
