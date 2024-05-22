import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/components/loading.dart';
import 'package:util/components/no_task.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/constant.dart';
import 'package:util/modules/history/index.dart';
import 'package:util/modules/todolist/bloc/todo/todo_bloc.dart';
import 'package:util/modules/todolist/components/todo_item.dart';
import 'package:util/modules/todolist/entities/todo.dart';
import 'package:util/modules/todolist/widgets/dialog_add_todo.dart';
import 'package:util/modules/todolist/widgets/inherit_todo.dart';

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
  final TextEditingController _todoCtrl = TextEditingController();
  final TextEditingController _typeCtrl = TextEditingController(text: 'Noun');
  List<TodoModel> todos = const <TodoModel>[];
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(const LoadTodos());
  }

  void _addTodo() {
    if (_todoCtrl.text.trim().isNotEmpty) {
      final todo = TodoModel(
        uuid: Constant.uuid(),
        title: _todoCtrl.text.trim(),
        type: _typeCtrl.text.trim(),
        isChecked: false,
        datetime: Constant.now('dd-MM-yyyy'),
      );
      context.read<TodoBloc>().add(AddTodo(todo: todo, todos: todos));
      Navigator.of(context).pop();
    }
  }

  void _deleteTodo({required TodoModel todo}) {
    context.read<TodoBloc>().add(DeleteTodo(todo: todo, todos: todos));
  }

  void _deleteAllTodos() {
    context.read<TodoBloc>().add(const DeleteAllTodos());
    Navigator.of(context).pop();
  }

  void _toggleCheckedItem({required TodoModel todo}) {
    context.read<TodoBloc>().add(ToggleTodo(todo: todo, todos: todos));
  }

  @override
  void dispose() {
    _todoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorAppbar = Colors.indigo;
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
        title: const Text(
          'Word List',
          style: TextStyle(fontWeight: FontWeight.bold, color: colorAppbar),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(HistoryScreen.routeName);
            },
            icon: const Icon(Icons.history_edu, color: colorAppbar),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final boxRadius = BorderRadius.circular(20.0);
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: boxRadius), //this right here
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Delete all words?',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon:
                                    const Icon(Icons.clear, color: Colors.red),
                              ),
                              const SizedBox(width: 40),
                              IconButton(
                                onPressed: _deleteAllTodos,
                                icon: const Icon(Icons.check,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  });
            },
            icon: const Icon(Icons.delete_forever, color: colorAppbar),
          ),
        ],
      ),
      body: InheritedTodo(
        toggleCheckedItem: _toggleCheckedItem,
        deleteTodo: _deleteTodo,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (BuildContext context, TodoState state) {
              if (state.status != Progress.loaded) {
                return const Loading();
              }
              if (state.status == Progress.loaded && state.todos.isEmpty) {
                todos = state.todos;
                return const NoTask(
                  color: Colors.blueGrey,
                  label: 'There is no word!',
                );
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
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final boxRadius = BorderRadius.circular(20.0);
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: boxRadius), //this right here
                child: DialogAddTodo(
                  todoCtrl: _todoCtrl,
                  boxRadius: boxRadius,
                  addTodo: _addTodo,
                  typeCtrl: _typeCtrl,
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
