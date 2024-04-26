import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/components/loading.dart';
import 'package:util/components/no_task.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/constant.dart';
import 'package:util/modules/todolist/bloc/todo/todo_bloc.dart';
import 'package:util/modules/todolist/components/todo_item.dart';
import 'package:util/modules/todolist/entities/todo.dart';

class TodoScreen extends StatefulWidget {
  static const String routeName = 'todo';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const TodoScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoModel> todos = const <TodoModel>[];
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(const LoadTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
        title: const Text(
          'To Do List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, TodoState state) {
            if (state.status != Progress.loaded) {
              return const Loading();
            }
            if (state.status == Progress.loaded && state.todos.isEmpty) {
              return const NoTask(color: Colors.blueGrey);
            }
            return ListView.builder(
              itemCount: state.todos.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                todos = state.todos;
                return TodoItem(todo: state.todos[index]);
              },
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              final todo = TodoModel(
                uuid: Constant.uuid(),
                title: Constant.uuid(),
                isChecked: false,
                datetime: Constant.now(),
              );
              context.read<TodoBloc>().add(AddTodo(todo: todo, todos: todos));
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.small(
            onPressed: () {},
            child: const Icon(Icons.history),
          ),
        ],
      ),
    );
  }
}
