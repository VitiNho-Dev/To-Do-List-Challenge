import 'package:flutter/material.dart';
import 'package:todo_list_app/data/models/task.dart';
import 'package:todo_list_app/data/repositories/task_repository.dart';
import 'package:todo_list_app/utils/errors/error_messages.dart';

import 'states/detail_state.dart';

class DetailViewmodel extends ValueNotifier<DetailState> {
  final TaskRepository _taskRepository;

  DetailViewmodel(this._taskRepository) : super(DetailStateEmpty());

  void updateTask(Task task) {
    final result = _taskRepository.updateTask(task);

    if (result.isNotEmpty) {
      value = DetailStateSuccess(tasks: result);
      return;
    }

    value = DetailStateError(message: ErrorMessages.taskNotUpdated);
  }

  void deleteTask(Task task) {
    final result = _taskRepository.deleteTask(task.id);

    if (result.isNotEmpty) {
      value = DetailStateSuccess(tasks: result);
      return;
    }

    value = DetailStateError(message: ErrorMessages.taskNotDeleted);
  }
}
