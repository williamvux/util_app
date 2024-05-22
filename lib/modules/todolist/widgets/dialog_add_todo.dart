import 'package:flutter/material.dart';
import 'package:util/modules/todolist/widgets/dropdown_type_word.dart';

class DialogAddTodo extends StatefulWidget {
  final BorderRadiusGeometry boxRadius;
  final TextEditingController todoCtrl;
  final TextEditingController typeCtrl;
  final void Function() addTodo;

  const DialogAddTodo({
    super.key,
    required this.boxRadius,
    required this.todoCtrl,
    required this.typeCtrl,
    required this.addTodo,
  });

  @override
  State<DialogAddTodo> createState() => _DialogAddTodoState();
}

class _DialogAddTodoState extends State<DialogAddTodo> {
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
        color: Colors.yellow.shade100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: const Text(
              'Word',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            side: const BorderSide(color: Colors.white),
            backgroundColor: Colors.amber.shade100,
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextField(
              controller: widget.todoCtrl,
              decoration: const InputDecoration(
                hintText: 'Word',
              ),
            ),
          ),
          const SizedBox(height: 20),
          DropdownTypeWord(typeCtrl: widget.typeCtrl),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: widget.addTodo,
            icon: const Icon(Icons.edit, size: 20),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
