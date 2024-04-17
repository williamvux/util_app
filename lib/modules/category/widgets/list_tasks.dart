import 'package:flutter/material.dart';
import 'package:util/modules/category/components/item_task.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';

class ListTasks extends StatelessWidget {
  final List<TaskModel> tasks;
  final TypeTask typeTask;
  final void Function({
    required TaskModel task,
    required TypeTask type,
    required int index,
    required List<TaskModel> tasks,
  }) toggleCheckedItem;
  final void Function({
    required TypeTask type,
    required int index,
    required List<TaskModel> tasks,
  }) deleteTask;

  const ListTasks({
    super.key,
    required this.tasks,
    required this.typeTask,
    required this.toggleCheckedItem,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final task = tasks[index];
          return ItemTask(
            task: task,
            toggleCheckedItem: ({required TaskModel task}) {
              toggleCheckedItem(
                index: index,
                task: task,
                tasks: tasks,
                type: typeTask,
              );
            },
            onDismissed: (DismissDirection _) {
              deleteTask(
                index: index,
                tasks: tasks,
                type: typeTask,
              );
            },
          );
        },
      ),
    );
  }
}
