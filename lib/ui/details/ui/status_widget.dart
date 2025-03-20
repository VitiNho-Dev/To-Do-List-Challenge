import 'package:flutter/material.dart';

import '../../core/widgets/card_item_completed.dart';
import '../../core/widgets/card_item_not_completed.dart';
import 'content_topic_widget.dart';

class StatusWidget extends StatefulWidget {
  final bool status;
  final void Function(bool) newStatus;

  const StatusWidget({
    super.key,
    required this.newStatus,
    required this.status,
  });

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  late bool completed;

  @override
  void initState() {
    super.initState();
    completed = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return ContentTopicWidget(
      title: 'Status da tarefa',
      child: InkWell(
        onTap: () {
          completed = !completed;
          widget.newStatus(completed);
          setState(() {});
        },
        child:
            completed
                ? CardItemCompleted(title: 'Tarefa concluída')
                : CardItemNotCompleted(title: 'Tarefa não concluída'),
      ),
    );
  }
}
