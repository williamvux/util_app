part of 'iutask_bloc.dart';

final class IUTaskInitial extends TaskState {
  const IUTaskInitial({
    super.tasks = const <TaskModel>[],
    super.status = Progress.initial,
  });
}

final class IUTaskLoading extends TaskState {
  const IUTaskLoading({
    super.tasks = const <TaskModel>[],
    super.status = Progress.loading,
  });
}

final class IUTaskLoaded extends TaskState {
  const IUTaskLoaded({
    required super.tasks,
    super.status = Progress.loaded,
  });
}

final class IUTaskError extends TaskState {
  const IUTaskError({
    super.tasks = const <TaskModel>[],
    super.status = Progress.error,
  });
}
