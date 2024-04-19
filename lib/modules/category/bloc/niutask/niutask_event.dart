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

  const ToggleNIUTask({required this.model});

  @override
  List<Object> get props => [model];
}

final class DeleteNIUTask extends TaskEvent {
  final TaskModel task;
  final List<TaskModel> tasks;

  const DeleteNIUTask({required this.task, required this.tasks});

  @override
  List<Object> get props => [task, tasks];
}

final class DeleteAllNIUTasks extends TaskEvent {
  const DeleteAllNIUTasks();

  @override
  List<Object> get props => [];
}
