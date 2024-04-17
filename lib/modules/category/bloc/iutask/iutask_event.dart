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
  final int index;
  final List<TaskModel> tasks;

  const ToggleIUTask({
    required this.model,
    required this.index,
    required this.tasks,
  });

  @override
  List<Object> get props => [model, index, tasks];
}

final class DeleteIUTask extends TaskEvent {
  final int index;
  final List<TaskModel> tasks;

  const DeleteIUTask({required this.index, required this.tasks});

  @override
  List<Object> get props => [index, tasks];
}

final class DeleteAllIUTasks extends TaskEvent {
  const DeleteAllIUTasks();

  @override
  List<Object> get props => [];
}
