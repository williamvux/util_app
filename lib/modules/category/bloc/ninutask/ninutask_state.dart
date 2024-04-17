part of 'ninutask_bloc.dart';

final class NINUTaskInitial extends TaskState {
  const NINUTaskInitial({
    super.tasks = const <TaskModel>[],
    super.status = Progress.initial,
  });
}

final class NINUTaskLoading extends TaskState {
  const NINUTaskLoading({
    super.tasks = const <TaskModel>[],
    super.status = Progress.loading,
  });
}

final class NINUTaskLoaded extends TaskState {
  const NINUTaskLoaded({
    required super.tasks,
    super.status = Progress.loaded,
  });
}

final class NINUTaskError extends TaskState {
  const NINUTaskError({
    super.tasks = const <TaskModel>[],
    super.status = Progress.error,
  });
}
