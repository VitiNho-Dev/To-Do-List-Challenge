import 'dart:developer';

import '../../utils/errors/custom_errors.dart';
import '../../utils/errors/error_messages.dart';
import '../../utils/result.dart';
import '../models/task.dart';
import '../services/api_client.dart';

abstract interface class TaskRepository {
  Future<Result<List<Task>>> fetchTasksFromApi();
  List<Task> createTask(Task task);
  List<Task> updateTask(Task task);
  List<Task> deleteTask(int id);
}

class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;

  TaskRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  List<Task> localTasks = [];

  @override
  Future<Result<List<Task>>> fetchTasksFromApi() async {
    try {
      final result = await _apiClient.getTasks();

      if (result is Error) {
        log('Error fetching tasks: ${(result as Error).error}');
        return Result.error((result as Error).error);
      }

      final data = (result as Ok<Map<String, dynamic>>).value;
      final todos = data['todos'];

      if (todos is! List || todos.isEmpty) {
        log('No tasks found or invalid data format.');
        return Result.ok([]);
      }

      localTasks = todos.map((task) => Task.fromJson(task)).toList();

      return Result.ok(localTasks);
    } catch (error) {
      log('Error fetching tasks: $error');
      return Result.error(UnexpectedError(message: ErrorMessages.unexpected));
    }
  }

  @override
  List<Task> createTask(Task task) {
    final taskId = localTasks.isNotEmpty ? localTasks.last.id + 1 : 1;
    final newTask = task.copyWith(id: taskId);
    localTasks = [...localTasks, newTask];

    log('Task created: $newTask. Total tasks: ${localTasks.length}');
    return localTasks;
  }

  int? _getIndex(int id) {
    final index = localTasks.indexWhere((task) => task.id == id);
    return index >= 0 ? index : null;
  }

  @override
  List<Task> updateTask(Task task) {
    final index = _getIndex(task.id);
    if (index == null) {
      throw RepositoryError(message: ErrorMessages.taskNotFound);
    }

    localTasks[index] = task;
    log('Task updated: $task. Total tasks: ${localTasks.length}');
    return localTasks;
  }

  @override
  List<Task> deleteTask(int id) {
    final index = _getIndex(id);
    if (index == null) {
      throw RepositoryError(message: ErrorMessages.taskNotFound);
    }

    final removedTask = localTasks.removeAt(index);
    log('Task deleted: $removedTask. Total tasks: ${localTasks.length}');

    return localTasks;
  }
}
