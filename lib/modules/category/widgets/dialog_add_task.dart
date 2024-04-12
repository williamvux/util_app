import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/entities/task.dart';

class DialogAddTask extends StatelessWidget {
  const DialogAddTask({
    super.key,
    required TextEditingController taskCtrl,
  }) : _taskCtrl = taskCtrl;

  final TextEditingController _taskCtrl;

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
            onPressed: () {
              if (_taskCtrl.text.trim().isNotEmpty) {
                TaskModel model = TaskModel(title: _taskCtrl.text.trim());
                GetIt.I<IUBox>().box.add(model);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.edit, size: 20),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
