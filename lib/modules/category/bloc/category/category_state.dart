part of 'category_bloc.dart';

sealed class IUTaskState extends Equatable {
  final Progress status;
  final List<TaskModel> tasks;
  const IUTaskState({required this.tasks, required this.status});

  @override
  List<Object> get props => [tasks, status];
}

final class IUTaskInitial extends IUTaskState {
  const IUTaskInitial({
    super.tasks = const <TaskModel>[],
    super.status = Progress.initial,
  });
}

final class IUTaskLoading extends IUTaskState {
  const IUTaskLoading({
    super.tasks = const <TaskModel>[],
    super.status = Progress.loading,
  });
}

final class IUTaskLoaded extends IUTaskState {
  const IUTaskLoaded({
    required super.tasks,
    super.status = Progress.loaded,
  });
}

final class IUTaskError extends IUTaskState {
  const IUTaskError({
    super.tasks = const <TaskModel>[],
    super.status = Progress.error,
  });
}
