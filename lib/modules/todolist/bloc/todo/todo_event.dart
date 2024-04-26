part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class LoadTodos extends TodoEvent {
  const LoadTodos();
}

final class AddTodo extends TodoEvent {
  final TodoModel todo;
  final List<TodoModel> todos;

  const AddTodo({required this.todo, required this.todos});

  @override
  List<Object> get props => [todo];
}
