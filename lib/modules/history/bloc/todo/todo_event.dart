part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class LoadMapTodo extends TodoEvent {
  const LoadMapTodo();
}
