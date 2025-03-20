import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_app/data/models/task.dart';
import 'package:todo_list_app/data/repositories/task_repository.dart';
import 'package:todo_list_app/data/services/api_client.dart';
import 'package:todo_list_app/utils/errors/custom_errors.dart';
import 'package:todo_list_app/utils/errors/error_messages.dart';
import 'package:todo_list_app/utils/result.dart';

class ApiClientMock extends Mock implements ApiClient {}

void main() {
  late ApiClient apiClient;
  late TaskRepositoryImpl taskRepository;

  setUp(() {
    apiClient = ApiClientMock();
    taskRepository = TaskRepositoryImpl(apiClient: apiClient);
  });

  group("TaskRepository", () {
    group("fetchTasksFromApi", () {
      test("should update localTasks with tasks from API", () async {
        when(() => apiClient.getTasks()).thenAnswer(
          (_) async => Result.ok({
            'todos': [
              {'id': 1, 'todo': 'Task 1', 'completed': false},
              {'id': 2, 'todo': 'Task 2', 'completed': true},
            ],
          }),
        );

        final result = await taskRepository.fetchTasksFromApi();

        expect(result, isA<Ok<List<Task>>>());
        expect(taskRepository.localTasks.length, 2);
        expect(taskRepository.localTasks[0].id, 1);
        expect(taskRepository.localTasks[1].completed, true);
      });

      test(
        "should set localTasks to an empty list when API returns no tasks",
        () async {
          when(
            () => apiClient.getTasks(),
          ).thenAnswer((_) async => Result.ok({'todos': []}));

          final result = await taskRepository.fetchTasksFromApi();

          expect(result, isA<Ok<List<Task>>>());
          expect(taskRepository.localTasks.isEmpty, true);
        },
      );

      test("should not update localTasks when API call fails", () async {
        when(() => apiClient.getTasks()).thenAnswer(
          (_) async =>
              Result.error(ApiError(message: "API Error", statusCode: 500)),
        );

        final result = await taskRepository.fetchTasksFromApi();

        expect(result, isA<Error>());
        expect(taskRepository.localTasks.isEmpty, true);
      });
    });

    group("createTask", () {
      test("should create a task", () {
        final task = Task(id: 1, title: 'Task 1', completed: false);

        final result = taskRepository.createTask(task);

        expect(result.length, 1);
        expect(result[0].id, 1);
        expect(result[0].title, 'Task 1');
        expect(result[0].completed, false);
      });
    });

    group("updateTask", () {
      test("should update a task", () {
        final task = Task(id: 1, title: 'Task 1', completed: true);
        taskRepository.localTasks = [task];

        final updatedTask = Task(id: 1, title: 'Task 1', completed: false);
        final result = taskRepository.updateTask(updatedTask);

        expect(result, isA<Ok<List<Task>>>());

        final tasks = (result as Ok<List<Task>>).value;

        expect(tasks.length, 1);
        expect(tasks[0].id, 1);
        expect(tasks[0].title, 'Task 1');
        expect(tasks[0].completed, false);
      });

      test("should throw an error when updating a non-existent task", () async {
        final task = Task(id: 1, title: 'Task 1', completed: true);
        taskRepository.localTasks = [task];

        final updatedTask = Task(id: 2, title: 'Task 2', completed: false);

        final result = taskRepository.updateTask(updatedTask);

        expect(result, isA<Error>());

        final error = (result as Error).error;

        expect(error, isA<RepositoryError>());
        expect(error.message, ErrorMessages.taskNotFound);
      });
    });

    group("deleteTask", () {
      test("should delete a task", () {
        final task = Task(id: 1, title: 'Task 1', completed: false);
        taskRepository.localTasks = [task];

        taskRepository.deleteTask(1);
        expect(taskRepository.localTasks.length, 0);
      });

      test("should throw an error when deleting a non-existent task", () {
        final task = Task(id: 1, title: 'Task 1', completed: false);
        taskRepository.localTasks = [task];

        final result = taskRepository.deleteTask(2);

        expect(result, isA<Error>());

        final error = (result as Error).error;

        expect(error, isA<RepositoryError>());
        expect(error.message, ErrorMessages.taskNotFound);
      });
    });
  });
}
