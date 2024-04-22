part of 'inutask_bloc.dart';

final class INUTaskInitial extends TaskState {
  const INUTaskInitial()
      : super(
          status: Progress.initial,
          tasks: const <TaskModel>[],
        );
}

final class INUTaskLoading extends TaskState {
  const INUTaskLoading()
      : super(
          status: Progress.loading,
          tasks: const <TaskModel>[],
        );
}

final class INUTaskLoaded extends TaskState {
  const INUTaskLoaded({required super.tasks}) : super(status: Progress.loaded);
}

final class INUTaskError extends TaskState {
  const INUTaskError()
      : super(
          status: Progress.error,
          tasks: const <TaskModel>[],
        );
}
