import 'package:flutter/material.dart';

class DialogAddTask extends StatelessWidget {
  final void Function() onAddTask;
  final TextEditingController _taskCtrl;
  const DialogAddTask({
    super.key,
    required TextEditingController taskCtrl,
    required this.onAddTask,
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
          ElevatedButton.icon(
            onPressed: onAddTask,
            icon: const Icon(Icons.edit, size: 20),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
