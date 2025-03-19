import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/details/ui/content_topic_widget.dart';
import 'package:todo_list_app/ui/home/widgets/card_item.dart';

import '../../core/themes/colors.dart';

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
                ? CardItem(
                  title: Text('Tarefa concluída'),
                  elevation: 0,
                  color: AppColorsDark.darkBlue4,
                  icon: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColorsDark.lightGreen,
                    ),
                    child: Icon(Icons.check, color: AppColorsDark.green),
                  ),
                )
                : CardItem(
                  title: Text('Tarefa não concluída'),
                  color: AppColorsDark.darkBlue3,
                  icon: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColorsDark.white,
                    ),
                  ),
                ),
      ),
    );
  }
}
