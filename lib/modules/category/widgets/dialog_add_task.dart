import 'package:flutter/material.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';

class DialogAddTask extends StatelessWidget {
  final void Function({
    required TypeTask typeTask,
    required List<TaskModel> tasks,
  }) onAddTask;
  final List<TaskModel> tasks;
  final TextEditingController _taskCtrl;
  final TypeTask typeTask;
  final Color color;
  final BorderRadiusGeometry boxRadius;
  const DialogAddTask({
    super.key,
    required TextEditingController taskCtrl,
    required this.onAddTask,
    required this.typeTask,
    required this.color,
    required this.boxRadius,
    required this.tasks,
  }) : _taskCtrl = taskCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
        top: 50,
        bottom: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(
              mapBoxTitle[typeTask] ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
            side: const BorderSide(color: Colors.white),
            backgroundColor: color,
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextField(
              controller: _taskCtrl,
              decoration: const InputDecoration(
                hintText: 'Task',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              onAddTask(typeTask: typeTask, tasks: tasks);
            },
            icon: const Icon(Icons.edit, size: 20),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
