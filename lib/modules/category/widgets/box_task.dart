import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/enum/index.dart';
import 'package:util/modules/category/bloc/common.dart';
import 'package:util/modules/category/components/loading.dart';
import 'package:util/modules/category/components/no_task.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';
import 'package:util/modules/category/widgets/list_tasks.dart';

class BoxTask<B extends Bloc<TaskEvent, TaskState>> extends StatelessWidget {
  List<TaskModel> tasks = const <TaskModel>[];
  final double widthEachBox;
  final double heightEachBox;
  final String placeholder;
  final Color boxColor;
  final TypeTask typeTask;
  final void Function({
    required TypeTask typeTask,
    required Color color,
    required List<TaskModel> tasks,
  }) openDialog;
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
  final void Function({required TypeTask typeTask}) deleteAllTasks;

  BoxTask({
    super.key,
    required this.widthEachBox,
    required this.heightEachBox,
    required this.placeholder,
    required this.boxColor,
    required this.deleteAllTasks,
    required this.typeTask,
    required this.openDialog,
    required this.toggleCheckedItem,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    final heightContent = heightEachBox - 10;
    final widthContent = widthEachBox - 10;
    const borderRadius = 2.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: boxColor,
      ),
      width: widthEachBox,
      height: heightEachBox,
      child: Stack(
        children: [
          Center(
            child: Text(
              placeholder,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white30,
              ),
            ),
          ),
          Center(
            child: Container(
              width: widthContent,
              height: heightContent,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.black26,
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              clipBehavior: Clip.hardEdge,
              width: widthContent,
              height: heightContent,
              child: BlocBuilder<B, TaskState>(
                builder: (context, state) {
                  if (state.status == Progress.loaded) {
                    if (state.tasks.isEmpty) {
                      return const NoTask();
                    } else {
                      tasks = state.tasks;
                      return ListTasks(
                        tasks: state.tasks,
                        typeTask: typeTask,
                        toggleCheckedItem: toggleCheckedItem,
                        deleteTask: deleteTask,
                      );
                    }
                  } else {
                    return const Loading();
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    openDialog(
                      typeTask: typeTask,
                      color: boxColor,
                      tasks: tasks,
                    );
                  },
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deleteAllTasks(typeTask: typeTask);
                  },
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  highlightColor: boxColor,
                  enableFeedback: true,
                  icon: const Icon(
                    Icons.delete_forever,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
