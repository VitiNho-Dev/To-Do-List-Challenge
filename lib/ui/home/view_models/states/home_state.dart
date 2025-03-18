import '../../../../data/models/task.dart';
import '../../../../utils/errors/custom_errors.dart';

abstract interface class HomeState {}

final class HomeStateEmpty extends HomeState {}

final class HomeStateLoading extends HomeState {}

final class HomeStateError extends HomeState {
  final Failure error;

  HomeStateError(this.error);
}

final class HomeStateSuccess extends HomeState {
  final List<Task> tasks;
  final List<Task>? completedTasks;

  HomeStateSuccess(this.tasks, this.completedTasks);
}
