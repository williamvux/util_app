part of 'niutask_bloc.dart';

final class LoadingNIUTasks extends TaskEvent {
  const LoadingNIUTasks();

  @override
  List<Object> get props => [];
}

final class AddNIUTask extends TaskEvent {
  final TaskModel model;
  final List<TaskModel> tasks;

  const AddNIUTask({required this.model, required this.tasks});

  @override
  List<Object> get props => [model, tasks];
}

final class ToggleNIUTask extends TaskEvent {
  final TaskModel model;
  final int index;
  final List<TaskModel> tasks;

  const ToggleNIUTask({
    required this.model,
    required this.index,
    required this.tasks,
  });

  @override
  List<Object> get props => [model, index, tasks];
}

final class DeleteNIUTask extends TaskEvent {
  final int index;
  final List<TaskModel> tasks;

  const DeleteNIUTask({required this.index, required this.tasks});

  @override
  List<Object> get props => [index, tasks];
}

final class DeleteAllNIUTasks extends TaskEvent {
  const DeleteAllNIUTasks();

  @override
  List<Object> get props => [];
}
