import 'package:flutter/widgets.dart';

import '../../../utils/result.dart';
import '../../../data/models/task.dart';
import '../../../data/repositories/task_repository.dart';
import 'states/home_state.dart';

class HomeViewmodel extends ValueNotifier<HomeState> {
  final TaskRepository _taskRepository;

  HomeViewmodel(this._taskRepository) : super(HomeStateEmpty());

  ({List<Task> notCompleted, List<Task> completed}) _filterTheList(
    List<Task> tasks,
  ) {
    final notCompleted = tasks.where((t) => t.completed == false).toList();
    final completed = tasks.where((t) => t.completed == true).toList();

    return (notCompleted: notCompleted, completed: completed);
  }

  void fetchTaksUpdated(List<Task> tasks) {
    final (:notCompleted, :completed) = _filterTheList(tasks);

    value = HomeStateSuccess(notCompleted, completed);
  }

  Future<void> getTasks() async {
    value = HomeStateLoading();

    final result = await _taskRepository.fetchTasksFromApi();

    switch (result) {
      case Ok<List<Task>>():
        {
          final (:notCompleted, :completed) = _filterTheList(result.value);

          value = HomeStateSuccess(notCompleted, completed);
        }
      case Error():
        {
          value = HomeStateError(result.error);
        }
    }
  }

  void addTask(String nameTask) {
    final task = Task(title: nameTask);

    final result = _taskRepository.createTask(task);

    final (:notCompleted, :completed) = _filterTheList(result);

    value = HomeStateSuccess(notCompleted, completed);
  }

  void updateTask(Task task) {
    final newTask = task.copyWith(completed: !task.completed);

    final result = _taskRepository.updateTask(newTask);

    final (:notCompleted, :completed) = _filterTheList(result);

    value = HomeStateSuccess(notCompleted, completed);
  }
}
