import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/models/pair.dart';
import 'package:util/modules/todolist/entities/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial()) {
    on<LoadTodos>(_loadTodos);
    on<AddTodo>(_addTodo);
  }

  void _loadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(const TodoLoading());
    await Future.delayed(const Duration(seconds: 1));
    final sortedTodos = _sortTodos(todos: GetIt.I<TodoBox>().box.values.toList());
    emit(TodoLoaded(todos: sortedTodos));
  }

  void _addTodo(AddTodo event, Emitter<TodoState> emit) async {
    await GetIt.I<TodoBox>().box.put(event.todo.uuid, event.todo);
    
    final todos = List<TodoModel>.from(event.todos)..add(event.todo);
    final sortedTodos = _sortTodos(todos: todos);

    emit(TodoLoaded(todos: sortedTodos));
  }

  List<TodoModel> _sortTodos({required List<TodoModel> todos}) {
    final Pair<List<TodoModel>, List<TodoModel>> pair = Pair(
      List<TodoModel>.empty(growable: true),
      List<TodoModel>.empty(growable: true),
    );

    for (var todo in todos) {
      if (todo.isChecked) {
        pair.first.add(todo);
      } else {
        pair.second.add(todo);
      }
    }
    pair.second.addAll(pair.first);

    return pair.second;
  }
}
