import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../core/themes/colors.dart';
import 'card_item.dart';

class ListViewTasks extends StatelessWidget {
  final List<Task> tasks;
  final void Function(Task)? onChanged;
  final void Function(Task) navigateToDetail;

  const ListViewTasks({
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
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text("TO DO", style: TextStyle(fontSize: 16)),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final task = tasks[index];

              return CardItem(
                color: AppColorsDark.darkBlue3,
                title: Text(task.title),
                dueDate: task.dueDate,
                onTap: () => navigateToDetail(task),
                icon: InkWell(
                  onTap: () => onChanged!(task),
                  child: Icon(Icons.circle, size: 28),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
