import 'package:flutter/material.dart';

import '../../../data/models/task.dart';
import '../../../data/repositories/task_repository.dart';
import '../../../utils/errors/custom_errors.dart';
import '../../../utils/errors/error_messages.dart';
import '../../../utils/result.dart';
import 'states/detail_state.dart';

class DetailViewmodel extends ValueNotifier<DetailState> {
  final TaskRepository _taskRepository;

  DetailViewmodel({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(DetailStateEmpty());

  void updateTask(Task task) {
    final result = _taskRepository.updateTask(task);

    switch (result) {
      case Ok<List<Task>>():
        value = DetailStateSuccess(tasks: result.value);
        break;
      case Error():
        if (result.error is RepositoryError) {
          value = DetailStateError(message: result.error.message);
          break;
        }
        value = DetailStateError(message: ErrorMessages.taskNotUpdated);
        break;
    }
  }

  void deleteTask(Task task) {
    final result = _taskRepository.deleteTask(task.id);

    switch (result) {
      case Ok<List<Task>>():
        value = DetailStateSuccess(tasks: result.value);
        break;
      case Error():
        if (result.error is RepositoryError) {
          value = DetailStateError(message: result.error.message);
          break;
        }
        value = DetailStateError(message: ErrorMessages.taskNotDeleted);
        break;
    }
  }
}
