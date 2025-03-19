import '../../../../data/models/task.dart';

abstract interface class DetailState {}

final class DetailStateEmpty extends DetailState {}

final class DetailStateSuccess extends DetailState {
  final List<Task> tasks;

  DetailStateSuccess({required this.tasks});
}

final class DetailStateError extends DetailState {
  final String message;

  DetailStateError({required this.message});
}
