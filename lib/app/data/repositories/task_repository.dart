import '../models/task.dart';

abstract interface class TaskRepository {
  Future<List<Task>> fetchTasks();
  Future<Task> createTask(Task task);
  Future<Task> updateTask(bool completed);
  Future<void> deleteTask(int id);
}
