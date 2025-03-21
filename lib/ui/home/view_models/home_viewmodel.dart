import 'package:flutter/widgets.dart';

import '../../../utils/errors/custom_errors.dart';
import '../../../utils/errors/error_messages.dart';
import '../../../utils/result.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/task_repository.dart';
import 'states/home_state.dart';

class HomeViewmodel extends ValueNotifier<HomeState> {
  final TaskRepository _taskRepository;

  HomeViewmodel({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(HomeStateEmpty());

  ({List<Task> notCompleted, List<Task> completed}) _filterTheList(
    List<Task> tasks,
  ) {
    final notCompleted = tasks.where((t) => t.completed == false).toList();
    final completed = tasks.where((t) => t.completed == true).toList();

    return (notCompleted: notCompleted, completed: completed);
  }

  void fetchTaksUpdated(List<Task> tasks) {
    if (tasks.isEmpty) {
      value = HomeStateEmpty();
      return;
    }

    final (:notCompleted, :completed) = _filterTheList(tasks);

    value = HomeStateSuccess(tasks: notCompleted, completedTasks: completed);
  }

  Future<void> getTasks() async {
    value = HomeStateLoading();

    final result = await _taskRepository.fetchTasksFromApi();

    switch (result) {
      case Ok<List<Task>>():
        final (:notCompleted, :completed) = _filterTheList(result.value);

        if (notCompleted.isEmpty && completed.isEmpty) {
          value = HomeStateEmpty();
          break;
        }

        value = HomeStateSuccess(
          tasks: notCompleted,
          completedTasks: completed,
        );
        break;
      case Error():
        if (result.error is RepositoryError) {
          value = HomeStateError(message: result.error.message);
          break;
        }
        value = HomeStateError(message: ErrorMessages.taskNotDeleted);
        break;
    }
  }

  void addTask(String titleTask) {
    final task = Task(title: titleTask);

    final result = _taskRepository.createTask(task);

    final (:notCompleted, :completed) = _filterTheList(result);

    value = HomeStateSuccess(tasks: notCompleted, completedTasks: completed);
  }

  void updateTask(Task task) {
    final newTask = task.copyWith(
      completed: !task.completed,
      dueDate: task.dueDate,
    );

    final result = _taskRepository.updateTask(newTask);

    switch (result) {
      case Ok<List<Task>>():
        final (:notCompleted, :completed) = _filterTheList(result.value);

        value = HomeStateSuccess(
          tasks: notCompleted,
          completedTasks: completed,
        );
        break;
      case Error():
        if (result.error is RepositoryError) {
          value = HomeStateError(message: result.error.message);
          break;
        }
        value = HomeStateError(message: ErrorMessages.taskNotDeleted);
        break;
    }
  }

  void deleteTask(Task task) {
    final result = _taskRepository.deleteTask(task.id);

    switch (result) {
      case Ok<List<Task>>():
        final (:notCompleted, :completed) = _filterTheList(result.value);

        value = HomeStateSuccess(
          tasks: notCompleted,
          completedTasks: completed,
        );
        break;
      case Error():
        if (result.error is RepositoryError) {
          value = HomeStateError(message: result.error.message);
          break;
        }
        value = HomeStateError(message: ErrorMessages.taskNotDeleted);
        break;
    }
  }
}
