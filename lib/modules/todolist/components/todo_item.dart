import 'package:flutter/material.dart';
import 'package:util/extension/string.dart';
import 'package:util/modules/todolist/entities/todo.dart';
import 'package:util/modules/todolist/widgets/inherit_todo.dart';

class TodoItem extends StatefulWidget {
  final TodoModel todo;
  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    final todo = widget.todo;
    final state = InheritedTodo.of(context);
    return isDeleted
        ? const SizedBox.shrink()
        : Column(
            key: ValueKey(todo.uuid),
            mainAxisSize: MainAxisSize.min,
            children: [
              Dismissible(
                key: ValueKey(todo.uuid),
                direction: DismissDirection.endToStart,
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
                onDismissed: (DismissDirection _) {
                  state.deleteTodo(todo: todo);
                  setState(() {
                    isDeleted = true;
                  });
                },
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  enableFeedback: true,
                  visualDensity: VisualDensity.compact,
                  leading: Checkbox(
                    side: const BorderSide(
                      color: Colors.blueAccent,
                      width: 3,
                    ),
                    activeColor: Colors.red.shade400,
                    value: todo.isChecked,
                    onChanged: (bool? isChecked) {
                      final newTodo = todo.copyWith(isChecked: isChecked);
                      state.toggleCheckedItem(todo: newTodo);
                    },
                  ),
                  title: Text(todo.title.capitalize()),
                  subtitle: Text(todo.datetime ?? ''),
                ),
              ),
              const Divider(thickness: 0.5, height: 0),
            ],
          );
  }
}
