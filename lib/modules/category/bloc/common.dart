import 'package:equatable/equatable.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/pair.dart';
import 'package:util/modules/category/entities/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

abstract class TaskState extends Equatable {
  final Progress status;
  final List<TaskModel> tasks;
  const TaskState({required this.tasks, required this.status});

  @override
  List<Object> get props => [tasks, status];
}

List<TaskModel> sortTasks({required List<TaskModel> tasks}) {
  Pair<List<TaskModel>, List<TaskModel>> pair = Pair(
    List<TaskModel>.empty(growable: true),
    List<TaskModel>.empty(growable: true),
  );

  for (var task in tasks) {
    if (task.isChecked) {
      pair.first.add(task);
    } else {
      pair.second.add(task);
    }
  }
  pair.second.addAll(pair.first);

  return pair.second;
}
