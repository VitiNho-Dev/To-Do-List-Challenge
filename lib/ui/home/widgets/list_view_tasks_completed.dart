import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_app/ui/core/themes/colors.dart';

import '../../../data/models/task.dart';
import 'card_item.dart';

class ListViewTasksCompleted extends StatelessWidget {
  final List<Task> tasks;

  const ListViewTasksCompleted({super.key, required this.tasks});

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
            child: Text("COMPLETED", style: TextStyle(fontSize: 16)),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CardItem(
                elevation: 0,
                color: AppColorsDark.darkBlue4,
                title: Text(
                  tasks[index].title,
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
                icon: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColorsDark.lightGreen,
                  ),
                  child: Icon(Icons.check, color: AppColorsDark.green),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
