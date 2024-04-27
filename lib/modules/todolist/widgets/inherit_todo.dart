import 'package:flutter/material.dart';
import 'package:util/modules/todolist/entities/todo.dart';

class InheritedTodo extends InheritedWidget {
  final void Function({required TodoModel todo}) deleteTodo;
  final void Function({required TodoModel todo}) toggleCheckedItem;

  const InheritedTodo({
    super.key,
    required super.child,
    required this.deleteTodo,
    required this.toggleCheckedItem,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static InheritedTodo of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedTodo>()!;
  }
}
