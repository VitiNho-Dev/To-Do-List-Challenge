import '../../../utils/result.dart';
import '../models/task.dart';
import '../services/api_client.dart';

abstract interface class TaskRepository {
  Future<Result<List<Task>>> getTasks();
  Future<List<Task>> createTask(Task task);
  Future<List<Task>> updateTask(Task task);
  Future<void> deleteTask(int id);
}

class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;

  TaskRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  late final List<Task> tasks;

  @override
  Future<Result<List<Task>>> getTasks() async {
    final result = await _apiClient.getTasks();

    switch (result) {
      case Ok<Map<String, dynamic>>():
        final data = result.value;
        tasks =
            List<Map<String, dynamic>>.from(data['todos']) //
            .map(Task.fromJson).toList();
        return Result.ok(tasks);
      case Error():
        return Result.error(result.error);
    }
  }

  @override
  Future<List<Task>> createTask(Task task) async {
    final taskId = tasks.last.id + 1;
    final newTask = task.copyWith(id: taskId);
    tasks.add(newTask);

    return tasks;
  }

  @override
  Future<List<Task>> updateTask(Task task) async {
    final index = tasks.indexWhere((element) => element.id == task.id);
    tasks[index] = task;

    return tasks;
  }

  @override
  Future<void> deleteTask(int id) async {
    final index = tasks.indexWhere((element) => element.id == id);
    tasks.removeAt(index);
  }
}
