import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../../routing/routes.dart';
import '../../core/themes/colors.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_icons.dart';
import 'custom_text_field.dart';
import '../view_models/home_viewmodel.dart';
import '../view_models/states/home_state.dart';
import 'list_view_tasks.dart';
import 'list_view_tasks_completed.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewmodel viewmodel;

  const HomeScreen({super.key, required this.viewmodel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewmodel get viewmodel => widget.viewmodel;

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    viewmodel.getTasks();
    controller = TextEditingController();
  }

  void navigateToDetail(Task task) async {
    final tasksUpdated = await Navigator.pushNamed(
      context,
      Routes.details,
      arguments: {"task": task},
    );

    if (tasksUpdated is List<Task>) {
      viewmodel.fetchTaksUpdated(tasksUpdated);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomIcon(
            icon: Icon(Icons.dehaze_sharp, size: 36),
            iconThemeData: theme.iconTheme.copyWith(
              color:
                  theme.brightness == Brightness.dark
                      ? AppColorsDark.darkBlue5
                      : AppColorsDark.darkBlue3,
            ),
          ),
        ),
        bottom: CustomTextField(
          controller: controller,
          padding: EdgeInsets.all(16),
          onTap: () {
            viewmodel.addTask(controller.text);
            controller.clear();
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: viewmodel,
        builder: (context, value, child) {
          if (value is HomeStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (value is HomeStateError) {
            return Center(child: Text(value.error.message));
          } else if (value is HomeStateSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListViewTasks(
                    tasks: value.tasks,
                    navigateToDetail: navigateToDetail,
                    onChanged: (task) => widget.viewmodel.updateTask(task),
                  ),
                  if (value.completedTasks != null)
                    ListViewTasksCompleted(
                      tasks: value.completedTasks!,
                      navigateToDetail: navigateToDetail,
                      onChanged: (task) => widget.viewmodel.updateTask(task),
                    ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
