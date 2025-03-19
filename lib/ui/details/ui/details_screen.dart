import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../core/widgets/circular_button.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_snackbar.dart';
import '../view_models/detail_viewmodel.dart';
import '../view_models/states/detail_state.dart';
import 'content_topic_widget.dart';
import 'custom_date_picker.dart';
import 'status_widget.dart';

class DetailScreen extends StatefulWidget {
  final DetailViewmodel viewmodel;

  const DetailScreen({super.key, required this.viewmodel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailViewmodel get viewmodel => widget.viewmodel;

  late TextEditingController controller;
  late bool completed;
  DateTime? dueDate;

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
    } else if (state is DetailStateSuccess) {
      Navigator.pop(context, state.tasks);
    }
  }

  late Map data;
  late Task task;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    task = data['task'];

    controller.text = task.title;
    completed = task.completed;
  }

  @override
  void dispose() {
    controller.dispose();
    viewmodel.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
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
                  child: TextField(controller: controller),
                ),
                StatusWidget(
                  newStatus: (status) {
                    completed = status;
                  },
                  status: task.completed,
                ),
                task.dueDate == null
                    ? ContentTopicWidget(
                      title: 'Adicionar data de vencimento da tarefa',
                      child: CustomDatePicker(
                        onChanged: (date) {
                          dueDate = date;
                        },
                      ),
                    )
                    : ContentTopicWidget(
                      title: 'Atualizar data de vencimento da tarefa',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Data de finalizar a tarefa:'),
                          CustomDatePicker(
                            dueDate: task.dueDate,
                            onChanged: (date) {
                              dueDate = date;
                            },
                          ),
                        ],
                      ),
                    ),
                CircularButton(
                  padding: EdgeInsets.all(16),
                  color: Colors.red,
                  child: Center(child: Text('Excluir Tarefa')),
                  onTap: () => viewmodel.deleteTask(task),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: CircularButton(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                onTap: () {
                  if (controller.text.isNotEmpty) {
                    task = task.copyWith(
                      id: task.id,
                      title: controller.text,
                      completed: completed,
                      dueDate: dueDate,
                    );
                    viewmodel.updateTask(task);
                  }
                },
                child: Center(child: Text('Salvar')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
