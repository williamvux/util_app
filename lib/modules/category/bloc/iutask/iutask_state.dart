part of 'iutask_bloc.dart';

final class IUTaskInitial extends TaskState {
  const IUTaskInitial()
      : super(
          status: Progress.initial,
          tasks: const <TaskModel>[],
        );
}

final class IUTaskLoading extends TaskState {
  const IUTaskLoading()
      : super(
          status: Progress.loading,
          tasks: const <TaskModel>[],
        );
}

final class IUTaskLoaded extends TaskState {
  const IUTaskLoaded({required super.tasks}) : super(status: Progress.loaded);
}

final class IUTaskError extends TaskState {
  const IUTaskError()
      : super(
          status: Progress.error,
          tasks: const <TaskModel>[],
        );
}
