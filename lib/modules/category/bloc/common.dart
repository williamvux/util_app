import 'package:equatable/equatable.dart';
import 'package:util/enum/index.dart';
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
