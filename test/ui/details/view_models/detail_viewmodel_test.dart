import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_app/data/models/task.dart';
import 'package:todo_list_app/data/repositories/task_repository.dart';
import 'package:todo_list_app/ui/details/view_models/detail_viewmodel.dart';
import 'package:todo_list_app/ui/details/view_models/states/detail_state.dart';
import 'package:todo_list_app/utils/errors/custom_errors.dart';
import 'package:todo_list_app/utils/errors/error_messages.dart';
import 'package:todo_list_app/utils/result.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

class TaskFake extends Fake implements Task {}

void main() {
  late TaskRepository taskRepository;
  late DetailViewmodel viewmodel;

  setUp(() {
    taskRepository = TaskRepositoryMock();
    viewmodel = DetailViewmodel(taskRepository: taskRepository);
    registerFallbackValue(TaskFake());
  });

  group('DetailViewmodel', () {
    final tasks = [
      Task(id: 1, title: 'Task 1', completed: false),
      Task(id: 2, title: 'Task 2', completed: false),
      Task(id: 3, title: 'Task 3', completed: true),
      Task(id: 4, title: 'Task 4', completed: true),
    ];

    group('updateTask', () {
      test('should update a task and return new task list', () {
        when(
          () => taskRepository.updateTask(any()),
        ).thenAnswer((_) => Result.ok(tasks));

        final task = Task(id: 1, title: 'Task 1', completed: true);

        viewmodel.updateTask(task);
        expect(viewmodel.value, isA<DetailStateSuccess>());

        final state = viewmodel.value as DetailStateSuccess;
        expect(state.tasks.isNotEmpty, true);

        verify(() => taskRepository.updateTask(any())).called(1);
      });

      test('should return a HomeStateError on type RepositoryError', () {
        when(() => taskRepository.updateTask(any())).thenAnswer(
          (_) => Result.error(
            RepositoryError(message: ErrorMessages.taskNotFound),
          ),
        );

        final task = Task(id: -1, title: 'Task 1', completed: true);

        viewmodel.updateTask(task);
        expect(viewmodel.value, isA<DetailStateError>());

        final state = viewmodel.value as DetailStateError;
        expect(state.message, ErrorMessages.taskNotFound);

        verify(() => taskRepository.updateTask(any())).called(1);
      });

      test(
        'should return a HomeStateError when type is different from type RepositoryError',
        () {
          when(() => taskRepository.updateTask(any())).thenAnswer(
            (_) => Result.error(
              UnexpectedError(message: ErrorMessages.unexpected),
            ),
          );

          final task = Task(id: -1, title: 'Task 1', completed: true);

          viewmodel.updateTask(task);
          expect(viewmodel.value, isA<DetailStateError>());

          final state = viewmodel.value as DetailStateError;
          expect(state.message, ErrorMessages.taskNotUpdated);

          verify(() => taskRepository.updateTask(any())).called(1);
        },
      );
    });

    group('deleteTask', () {
      test('should delete a task and return new task list', () {
        when(
          () => taskRepository.deleteTask(any()),
        ).thenAnswer((_) => Result.ok(tasks));

        final task = Task(id: 1, title: 'Task 1', completed: true);

        viewmodel.deleteTask(task);
        expect(viewmodel.value, isA<DetailStateSuccess>());

        final state = viewmodel.value as DetailStateSuccess;
        expect(state.tasks.isNotEmpty, true);

        verify(() => taskRepository.deleteTask(any())).called(1);
      });

      test('should return a HomeStateError on type RepositoryError', () {
        when(() => taskRepository.deleteTask(any())).thenAnswer(
          (_) => Result.error(
            RepositoryError(message: ErrorMessages.taskNotFound),
          ),
        );

        final task = Task(id: -1, title: 'Task 1', completed: true);

        viewmodel.deleteTask(task);
        expect(viewmodel.value, isA<DetailStateError>());

        final state = viewmodel.value as DetailStateError;
        expect(state.message, ErrorMessages.taskNotFound);

        verify(() => taskRepository.deleteTask(any())).called(1);
      });

      test(
        'should return a HomeStateError when type is different from type RepositoryError',
        () {
          when(() => taskRepository.deleteTask(any())).thenAnswer(
            (_) => Result.error(
              UnexpectedError(message: ErrorMessages.unexpected),
            ),
          );

          final task = Task(id: -1, title: 'Task 1', completed: true);

          viewmodel.deleteTask(task);
          expect(viewmodel.value, isA<DetailStateError>());

          final state = viewmodel.value as DetailStateError;
          expect(state.message, ErrorMessages.taskNotDeleted);

          verify(() => taskRepository.deleteTask(any())).called(1);
        },
      );
    });
  });
}
