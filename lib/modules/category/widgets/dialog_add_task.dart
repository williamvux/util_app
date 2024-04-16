import 'package:flutter/material.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/enum/index.dart';

class DialogAddTask extends StatelessWidget {
  final void Function<A extends BoxModel>({required TypeTask typeTask})
      onAddTask;
  final TextEditingController _taskCtrl;
  final TypeTask typeTask;
  final Color color;
  const DialogAddTask({
    super.key,
    required TextEditingController taskCtrl,
    required this.onAddTask,
    required this.typeTask,
    required this.color,
  }) : _taskCtrl = taskCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
        top: 50,
        bottom: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Chip(
            label: Text(
              mapBoxTitle[typeTask] ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: color,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              onAddTask<IUBox>(typeTask: typeTask);
            },
            icon: const Icon(Icons.edit, size: 20),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
