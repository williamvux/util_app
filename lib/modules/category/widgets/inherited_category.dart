import 'package:flutter/material.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';

class InheritedCategory extends InheritedWidget {
  @override
  final Widget child;

  final void Function({
    required TypeTask typeTask,
    required Color color,
    required List<TaskModel> tasks,
  }) openDialogAddTask;

  final void Function({
    required TypeTask type,
    required TaskModel task,
    required List<TaskModel> tasks,
  }) deleteTask;

  final void Function({required TypeTask typeTask}) deleteAllTasks;

  final void Function({
    required TaskModel task,
    required TypeTask type,
  }) toggleCheckedItem;

  const InheritedCategory({
    super.key,
    required this.child,
    required this.openDialogAddTask,
    required this.deleteTask,
    required this.deleteAllTasks,
    required this.toggleCheckedItem,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static InheritedCategory of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCategory>()!;
  }
}
