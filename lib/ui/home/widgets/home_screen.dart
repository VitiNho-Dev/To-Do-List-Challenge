import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/core/widgets/custom_app_bar.dart';
import 'package:todo_list_app/ui/home/widgets/list_view_tasks.dart';
import 'package:todo_list_app/ui/home/widgets/list_view_tasks_completed.dart';

import '../../core/widgets/custom_text_field.dart';
import '../view_models/home_viewmodel.dart';
import '../view_models/states/home_state.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewmodel viewmodel;

  const HomeScreen({super.key, required this.viewmodel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewmodel.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        bottom: CustomTextField(
          onSubmitted: widget.viewmodel.addTask,
          padding: EdgeInsets.all(16),
        ),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: widget.viewmodel,
          builder: (context, value, child) {
            if (value is HomeStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value is HomeStateSuccess) {
              return Column(
                children: [
                  ListViewTasks(tasks: value.tasks),
                  if (value.completedTasks != null)
                    ListViewTasksCompleted(tasks: value.completedTasks!),
                ],
              );
            } else if (value is HomeStateError) {
              return Center(child: Text(value.error.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
