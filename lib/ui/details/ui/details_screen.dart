import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../../utils/validators.dart';
import '../../core/themes/app_colors.dart';
import '../../core/widgets/circular_button.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_snackbar.dart';
import '../view_models/detail_viewmodel.dart';
import '../view_models/states/detail_state.dart';
import 'content_topic_widget.dart';
import 'select_due_date_widget.dart';
import 'status_widget.dart';

class DetailScreen extends StatefulWidget {
  final DetailViewmodel viewmodel;

  const DetailScreen({super.key, required this.viewmodel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with Validators {
  DetailViewmodel get viewmodel => widget.viewmodel;

  final formKey = GlobalKey<FormState>();

  late TextEditingController controller;
  late DateTime? dueDate;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    viewmodel.addListener(listener);
  }

  void listener() {
    final state = viewmodel.value;

    if (state is DetailStateError) {
      CustomSnackBar.showSnackBar(context, message: state.message);
      Navigator.pop(context);
    } else if (state is DetailStateSuccess) {
      Navigator.pop(context, state.tasks);
    }
  }

  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      final data =
          ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
      final task = data['task'] as Task;

      viewmodel.value = DetailStateInitial(task: task);
      controller.text = task.title;
      dueDate = task.dueDate;

      initialized = true;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    viewmodel.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.of(context);
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar(),
      body: ValueListenableBuilder(
        valueListenable: viewmodel,
        builder: (context, state, child) {
          if (state is DetailStateInitial) {
            var task = state.task;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContentTopicWidget(
                        title: 'Nome da tarefa',
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            controller: controller,
                            validator: validateTitle,
                            minLines: 1,
                            maxLines: null,
                          ),
                        ),
                      ),
                      StatusWidget(
                        status: task.completed,
                        newStatus: (status) {
                          task = task.copyWith(completed: status);
                        },
                      ),
                      SelectDueDateWidget(
                        dueDate: dueDate,
                        onChanged: (date) {
                          dueDate = date;
                        },
                        removeDate: () {
                          setState(() {
                            dueDate = null;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      CircularButton(
                        color: color.error,
                        onTap: () => viewmodel.deleteTask(task),
                        child: Center(
                          child: Text(
                            'Excluir Tarefa',
                            style: textStyle.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: CircularButton(
                      width: double.infinity,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          task = task.copyWith(
                            title: controller.text,
                            dueDate: dueDate,
                          );
                          viewmodel.updateTask(task);
                        }
                      },
                      child: Center(
                        child: Text('Salvar', style: textStyle.labelMedium),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
