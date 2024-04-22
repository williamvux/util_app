part of 'niutask_bloc.dart';

final class NIUTaskInitial extends TaskState {
  const NIUTaskInitial()
      : super(
          status: Progress.initial,
          tasks: const <TaskModel>[],
        );
}

final class NIUTaskLoading extends TaskState {
  const NIUTaskLoading()
      : super(
          status: Progress.loading,
          tasks: const <TaskModel>[],
        );
}

final class NIUTaskLoaded extends TaskState {
  const NIUTaskLoaded({required super.tasks}) : super(status: Progress.loaded);
}

final class NIUTaskError extends TaskState {
  const NIUTaskError()
      : super(
          status: Progress.error,
          tasks: const <TaskModel>[],
        );
}
