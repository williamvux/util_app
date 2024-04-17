part of 'inutask_bloc.dart';

final class INUTaskInitial extends TaskState {
  const INUTaskInitial({
    super.tasks = const <TaskModel>[],
    super.status = Progress.initial,
  });
}

final class INUTaskLoading extends TaskState {
  const INUTaskLoading({
    super.tasks = const <TaskModel>[],
    super.status = Progress.loading,
  });
}

final class INUTaskLoaded extends TaskState {
  const INUTaskLoaded({
    required super.tasks,
    super.status = Progress.loaded,
  });
}

final class INUTaskError extends TaskState {
  const INUTaskError({
    super.tasks = const <TaskModel>[],
    super.status = Progress.error,
  });
}
