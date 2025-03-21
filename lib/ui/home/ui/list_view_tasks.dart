import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../core/widgets/card_item_not_completed.dart';
import '../../core/widgets/custom_show_dialog.dart';

class ListViewTasks extends StatelessWidget {
  final List<Task> tasks;
  final void Function(Task)? taskStatusUpdate;
  final void Function(Task) navigateToDetail;
  final void Function(Task) excludeTask;

  const ListViewTasks({
    super.key,
    required this.tasks,
    this.taskStatusUpdate,
    required this.navigateToDetail,
    required this.excludeTask,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text("PENDENTE", style: textStyle.bodyMedium),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final task = tasks[index];

              return CardItemNotCompleted(
                title: task.title,
                dueDate: task.dueDate,
                onTap: () => navigateToDetail(task),
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
