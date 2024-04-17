import 'package:flutter/material.dart';
import 'package:util/extention/string.dart';
import 'package:util/models/constant.dart';
import 'package:util/modules/category/entities/task.dart';

class ItemTask extends StatelessWidget {
  final TaskModel task;
  final void Function(DismissDirection direction) onDismissed;
  final void Function({required TaskModel task}) toggleCheckedItem;

  const ItemTask({
    super.key,
    required this.task,
    required this.toggleCheckedItem,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.uuid),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      background: const ColoredBox(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 20),
          ],
        ),
      ),
      child: ListTile(
        dense: true,
        leading: Checkbox(
          side: const BorderSide(color: Colors.white, width: 3),
          activeColor: Colors.red.shade400,
          value: task.isChecked,
          onChanged: (bool? isChecked) {
            final model = task.copyWith(
              isChecked: isChecked,
            );
            toggleCheckedItem(task: model);
          },
        ),
        title: Text(
          task.title.capitalize(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            decoration: task.isChecked ? TextDecoration.lineThrough : null,
            decorationThickness: 2,
            decorationColor: Colors.white,
          ),
        ),
        subtitle: task.isChecked
            ? null
            : Text(
                task.datetime ?? Constant.now(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white60,
                ),
              ),
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }
}
