import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../core/widgets/card_item_completed.dart';
import '../../core/widgets/custom_show_dialog.dart';

class ListViewTasksCompleted extends StatelessWidget {
  final List<Task> tasks;
  final void Function(Task)? taskStatusUpdate;
  final void Function(Task) navigateToTaskDetail;
  final void Function(Task) excludeTask;

  const ListViewTasksCompleted({
    super.key,
    required this.tasks,
    this.taskStatusUpdate,
    required this.navigateToTaskDetail,
    required this.excludeTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "CONCLUÍDA",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final task = tasks[index];

              return CardItemCompleted(
                onTap: () => navigateToTaskDetail(task),
                dueDate: task.dueDate,
                title: task.title,
                lineThrough: true,
                onTapIcon: () => taskStatusUpdate!(task),
                onLongPress: () {
                  CustomAlertDialog.showAlertDialog(
                    context,
                    title: 'Excluir tarefa',
                    content: task.title,
                    onTap: () => excludeTask(task),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
