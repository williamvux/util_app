part of 'ninutask_bloc.dart';

final class NINUTaskInitial extends TaskState {
  const NINUTaskInitial()
      : super(
          status: Progress.initial,
          tasks: const <TaskModel>[],
        );
}

final class NINUTaskLoading extends TaskState {
  const NINUTaskLoading()
      : super(
          status: Progress.loading,
          tasks: const <TaskModel>[],
        );
}

final class NINUTaskLoaded extends TaskState {
  const NINUTaskLoaded({required super.tasks}) : super(status: Progress.loaded);
}

final class NINUTaskError extends TaskState {
  const NINUTaskError()
      : super(
          status: Progress.error,
          tasks: const <TaskModel>[],
        );
}
