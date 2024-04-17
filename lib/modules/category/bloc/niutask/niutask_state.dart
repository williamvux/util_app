part of 'niutask_bloc.dart';

final class NIUTaskInitial extends TaskState {
  const NIUTaskInitial({
    super.tasks = const <TaskModel>[],
    super.status = Progress.initial,
  });
}

final class NIUTaskLoading extends TaskState {
  const NIUTaskLoading({
    super.tasks = const <TaskModel>[],
    super.status = Progress.loading,
  });
}

final class NIUTaskLoaded extends TaskState {
  const NIUTaskLoaded({
    required super.tasks,
    super.status = Progress.loaded,
  });
}

final class NIUTaskError extends TaskState {
  const NIUTaskError({
    super.tasks = const <TaskModel>[],
    super.status = Progress.error,
  });
}
