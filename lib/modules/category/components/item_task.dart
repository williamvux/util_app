import 'package:flutter/material.dart';
import 'package:util/extention/string.dart';
import 'package:util/models/constant.dart';
import 'package:util/modules/category/bloc/category/category_bloc.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';

class ItemTask extends StatelessWidget {
  final int index;
  final TaskModel task;
  final void Function({required IUTaskEvent category}) toggleCheckedItem;
  const ItemTask({
    super.key,
    required this.index,
    required this.task,
    required this.toggleCheckedItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(task.uuid),
      dense: true,
      leading: Checkbox(
        activeColor: Colors.red.shade400,
        value: task.isChecked,
        onChanged: (bool? isChecked) {
          final model = task.copyWith(
            isChecked: isChecked,
          );
          toggleCheckedItem(
              category: ToggleItem(
            model: model,
            index: index,
            type: TypeTask.I_U,
          ));
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
                color: Colors.grey,
              ),
            ),
    );
  }
}
