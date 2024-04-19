part of 'ninutask_bloc.dart';

final class LoadingNINUTasks extends TaskEvent {
  const LoadingNINUTasks();

  @override
  List<Object> get props => [];
}

final class AddNINUTask extends TaskEvent {
  final TaskModel model;
  final List<TaskModel> tasks;

  const AddNINUTask({required this.model, required this.tasks});

  @override
  List<Object> get props => [model, tasks];
}

final class ToggleNINUTask extends TaskEvent {
  final TaskModel model;

  const ToggleNINUTask({required this.model});

  @override
  List<Object> get props => [model];
}

final class DeleteNINUTask extends TaskEvent {
  final TaskModel task;
  final List<TaskModel> tasks;

  const DeleteNINUTask({required this.task, required this.tasks});

  @override
  List<Object> get props => [task, tasks];
}

final class DeleteAllNINUTasks extends TaskEvent {
  const DeleteAllNINUTasks();

  @override
  List<Object> get props => [];
}
