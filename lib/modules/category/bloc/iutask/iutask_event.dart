part of 'iutask_bloc.dart';

final class LoadingIUTasks extends TaskEvent {
  const LoadingIUTasks();

  @override
  List<Object> get props => [];
}

final class AddIUTask extends TaskEvent {
  final TaskModel model;
  final List<TaskModel> tasks;

  const AddIUTask({required this.model, required this.tasks});

  @override
  List<Object> get props => [model, tasks];
}

final class ToggleIUTask extends TaskEvent {
  final TaskModel model;

  const ToggleIUTask({required this.model});

  @override
  List<Object> get props => [model];
}

final class DeleteIUTask extends TaskEvent {
  final TaskModel task;
  final List<TaskModel> tasks;

  const DeleteIUTask({required this.task, required this.tasks});

  @override
  List<Object> get props => [task, tasks];
}

final class DeleteAllIUTasks extends TaskEvent {
  const DeleteAllIUTasks();

  @override
  List<Object> get props => [];
}
