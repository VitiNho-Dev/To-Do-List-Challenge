import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_app/data/models/task.dart';
import 'package:todo_list_app/data/repositories/task_repository.dart';
import 'package:todo_list_app/ui/home/view_models/home_viewmodel.dart';
import 'package:todo_list_app/ui/home/view_models/states/home_state.dart';
import 'package:todo_list_app/utils/errors/custom_errors.dart';
import 'package:todo_list_app/utils/errors/error_messages.dart';
import 'package:todo_list_app/utils/result.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

class TaskFake extends Fake implements Task {}

void main() {
  late TaskRepository taskRepository;
  late HomeViewmodel viewmodel;

  setUp(() {
    taskRepository = TaskRepositoryMock();
    viewmodel = HomeViewmodel(taskRepository: taskRepository);
    registerFallbackValue(TaskFake());
  });

  group('HomeViewmodel', () {
    final tasks = [
      Task(id: 1, title: 'Task 1', completed: false),
      Task(id: 2, title: 'Task 2', completed: false),
      Task(id: 3, title: 'Task 3', completed: true),
      Task(id: 4, title: 'Task 4', completed: true),
    ];

    group('getTasks', () {
      test(
        'should return a HomeStateSuccess when the result is a task list',
        () async {
          when(
            () => taskRepository.fetchTasksFromApi(),
          ).thenAnswer((_) async => Result.ok(tasks));

          viewmodel.getTasks();
          expect(viewmodel.value, isA<HomeStateLoading>());

          await viewmodel.getTasks();
          expect(viewmodel.value, isA<HomeStateSuccess>());

          final state = viewmodel.value as HomeStateSuccess;
          expect(state.tasks.isNotEmpty, true);
          expect(state.completedTasks!.isNotEmpty, true);
        },
      );

      test('should return a HomeStateError when a result is Error', () async {
        when(() => taskRepository.fetchTasksFromApi()).thenAnswer(
          (_) async => Result.error(
            RepositoryError(message: ErrorMessages.taskNotFound),
          ),
        );

        viewmodel.getTasks();
        expect(viewmodel.value, isA<HomeStateLoading>());

        await viewmodel.getTasks();
        expect(viewmodel.value, isA<HomeStateError>());

        final state = viewmodel.value as HomeStateError;
        expect(state.error, isA<RepositoryError>());
        expect(state.error.message, ErrorMessages.taskNotFound);
      });

      test(
        'should return a HomeStateEmpty when the task list is empty',
        () async {
          when(
            () => taskRepository.fetchTasksFromApi(),
          ).thenAnswer((_) async => Result.ok([]));

          viewmodel.getTasks();
          expect(viewmodel.value, isA<HomeStateLoading>());

          await viewmodel.getTasks();
          expect(viewmodel.value, isA<HomeStateEmpty>());
        },
      );
    });

    group('createTask', () {
      test('should create a task and return a new task list', () {
        when(() => taskRepository.createTask(any())).thenAnswer((_) => tasks);

        viewmodel.addTask('Task 1');
        expect(viewmodel.value, isA<HomeStateSuccess>());

        final state = viewmodel.value as HomeStateSuccess;
        expect(state.tasks.isNotEmpty, true);
        expect(state.completedTasks!.isNotEmpty, true);

        verify(() => taskRepository.createTask(any())).called(1);
      });
    });

    group('fetchTasksUpdated', () {
      test('should return a task list with updated tasks', () {
        viewmodel.fetchTaksUpdated(tasks);
        expect(viewmodel.value, isA<HomeStateSuccess>());

        final state = viewmodel.value as HomeStateSuccess;
        expect(state.tasks.isNotEmpty, true);
        expect(state.completedTasks!.isNotEmpty, true);
      });

      test('should return a HomeStateEmpty when the task list is empty', () {
        viewmodel.fetchTaksUpdated([]);
        expect(viewmodel.value, isA<HomeStateEmpty>());
      });
    });

    group('updateTask', () {
      test('should update a task and return new task list', () {
        when(
          () => taskRepository.updateTask(any()),
        ).thenAnswer((_) => Result.ok(tasks));

        final task = Task(id: 1, title: 'Task 1', completed: true);

        viewmodel.updateTask(task);
        expect(viewmodel.value, isA<HomeStateSuccess>());

        final state = viewmodel.value as HomeStateSuccess;
        expect(state.tasks.isNotEmpty, true);
        expect(state.completedTasks!.isNotEmpty, true);

        verify(() => taskRepository.updateTask(any())).called(1);
      });

      test('should return a HomeStateError when updating the task', () {
        when(() => taskRepository.updateTask(any())).thenAnswer(
          (_) => Result.error(
            RepositoryError(message: ErrorMessages.taskNotFound),
          ),
        );

        final task = Task(id: -1, title: 'Task 1', completed: true);

        viewmodel.updateTask(task);
        expect(viewmodel.value, isA<HomeStateError>());

        final state = viewmodel.value as HomeStateError;
        expect(state.error, isA<RepositoryError>());
        expect(state.error.message, ErrorMessages.taskNotFound);

        verify(() => taskRepository.updateTask(any())).called(1);
      });
    });
  });
}
