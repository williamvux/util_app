part of 'inutask_bloc.dart';

final class LoadingINUTasks extends TaskEvent {
  const LoadingINUTasks();

  @override
  List<Object> get props => [];
}

final class AddINUTask extends TaskEvent {
  final TaskModel model;
  final List<TaskModel> tasks;

  const AddINUTask({required this.model, required this.tasks});

  @override
  List<Object> get props => [model, tasks];
}

final class ToggleINUTask extends TaskEvent {
  final TaskModel model;

  const ToggleINUTask({required this.model});

  @override
  List<Object> get props => [model];
}

final class DeleteINUTask extends TaskEvent {
  final TaskModel task;
  final List<TaskModel> tasks;

  const DeleteINUTask({required this.task, required this.tasks});

  @override
  List<Object> get props => [task, tasks];
}

final class DeleteAllINUTasks extends TaskEvent {
  const DeleteAllINUTasks();

  @override
  List<Object> get props => [];
}
