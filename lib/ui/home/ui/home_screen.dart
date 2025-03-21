import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../../routing/routes.dart';
import '../../../utils/validators.dart';
import '../../core/themes/app_colors.dart';
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

class _HomeScreenState extends State<HomeScreen> with Validators {
  HomeViewmodel get viewmodel => widget.viewmodel;

  late TextEditingController taskTitleController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewmodel.getTasks();
    taskTitleController = TextEditingController();
  }

  void navigateToTaskDetail(Task task) async {
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
    taskTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = AppColors.of(context);

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: CustomAppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomIcon(
              icon: Icon(Icons.dehaze_sharp, size: 36),
              iconThemeData: theme.iconTheme.copyWith(color: color.accent),
            ),
          ),
          bottom: CustomTextField(
            padding: EdgeInsets.all(16),
            controller: taskTitleController,
            validator: validateTitle,
            onTap: () {
              if (formKey.currentState!.validate()) {
                viewmodel.addTask(taskTitleController.text);
                taskTitleController.clear();
              }
            },
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: viewmodel,
          builder: (context, value, child) {
            if (value is HomeStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (value is HomeStateError) {
              return Center(
                child: Text(value.message, style: theme.textTheme.bodyLarge),
              );
            } else if (value is HomeStateEmpty) {
              return Center(
                child: Text(
                  'A lista de tarfes está vazia no momento! \nAdicione sua primeira tarefa no campo acima.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
            } else if (value is HomeStateSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListViewTasks(
                      tasks: value.tasks,
                      navigateToDetail: navigateToTaskDetail,
                      taskStatusUpdate: viewmodel.updateTask,
                      excludeTask: (task) {
                        viewmodel.deleteTask(task);
                        Navigator.pop(context);
                      },
                    ),
                    if (value.completedTasks != null)
                      ListViewTasksCompleted(
                        tasks: value.completedTasks!,
                        navigateToTaskDetail: navigateToTaskDetail,
                        taskStatusUpdate: viewmodel.updateTask,
                        excludeTask: (task) {
                          viewmodel.deleteTask(task);
                          Navigator.pop(context);
                        },
                      ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
