import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_app/data/models/task.dart';
import 'package:todo_list_app/ui/core/themes/colors.dart';
import 'package:todo_list_app/ui/home/widgets/card_item.dart';

class ListViewTasks extends StatelessWidget {
  final List<Task> tasks;

  const ListViewTasks({super.key, required this.tasks});

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
              return CardItem(
                color: AppColorsDark.darkBlue3,
                title: Text(tasks[index].title),
                icon: Icon(Icons.circle, size: 28),
              );
            },
          ),
        ],
      ),
    );
  }
}
