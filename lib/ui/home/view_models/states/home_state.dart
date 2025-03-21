import '../../../../data/models/task.dart';

abstract interface class HomeState {}

final class HomeStateEmpty extends HomeState {}

final class HomeStateLoading extends HomeState {}

final class HomeStateError extends HomeState {
  final String message;

  HomeStateError({required this.message});
}

final class HomeStateSuccess extends HomeState {
  final List<Task> tasks;
  final List<Task>? completedTasks;

  HomeStateSuccess({required this.tasks, this.completedTasks});
}
