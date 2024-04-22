import 'package:flutter/material.dart';
import 'package:util/modules/category/components/item_task.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';
import 'package:util/modules/category/widgets/inherited_category.dart';

class ListTasks extends StatelessWidget {
  final List<TaskModel> tasks;
  final TypeTask typeTask;

  const ListTasks({
    super.key,
    required this.tasks,
    required this.typeTask,
  });

  @override
  Widget build(BuildContext context) {
    final state = InheritedCategory.of(context);
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
              state.toggleCheckedItem(task: task, type: typeTask);
            },
            onDismissed: (DismissDirection _) {
              state.deleteTask(
                tasks: tasks,
                task: task,
                type: typeTask,
              );
            },
          );
        },
      ),
    );
  }
}
