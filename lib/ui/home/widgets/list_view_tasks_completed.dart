import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../core/themes/colors.dart';
import 'card_item.dart';

class ListViewTasksCompleted extends StatelessWidget {
  final List<Task> tasks;
  final void Function(Task)? onChanged;
  final void Function(Task) navigateToDetail;

  const ListViewTasksCompleted({
    super.key,
    required this.tasks,
    this.onChanged,
    required this.navigateToDetail,
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
            child: Text("COMPLETED", style: TextStyle(fontSize: 16)),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final task = tasks[index];

              return CardItem(
                elevation: 0,
                color: AppColorsDark.darkBlue4,
                onTap: () => navigateToDetail(task),
                dueDate: task.dueDate,
                title: Text(
                  task.title,
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                icon: InkWell(
                  onTap: () => onChanged!(task),
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColorsDark.lightGreen,
                    ),
                    child: Icon(Icons.check, color: AppColorsDark.green),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
