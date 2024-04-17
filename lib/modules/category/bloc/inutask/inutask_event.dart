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
  final int index;
  final List<TaskModel> tasks;

  const ToggleINUTask({
    required this.model,
    required this.index,
    required this.tasks,
  });

  @override
  List<Object> get props => [model, index, tasks];
}

final class DeleteINUTask extends TaskEvent {
  final int index;
  final List<TaskModel> tasks;

  const DeleteINUTask({required this.index, required this.tasks});

  @override
  List<Object> get props => [index, tasks];
}

final class DeleteAllINUTasks extends TaskEvent {
  const DeleteAllINUTasks();

  @override
  List<Object> get props => [];
}
