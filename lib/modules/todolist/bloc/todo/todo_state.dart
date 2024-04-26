part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  final Progress status;
  final List<TodoModel> todos;
  const TodoState({required this.todos, required this.status});

  @override
  List<Object> get props => [todos, status];
}

final class TodoInitial extends TodoState {
  const TodoInitial()
      : super(
          status: Progress.initial,
          todos: const <TodoModel>[],
        );
}

final class TodoLoading extends TodoState {
  const TodoLoading()
      : super(
          status: Progress.loading,
          todos: const <TodoModel>[],
        );
}

final class TodoLoaded extends TodoState {
  const TodoLoaded({required super.todos}) : super(status: Progress.loaded);
}

final class TodoError extends TodoState {
  const TodoError()
      : super(
          status: Progress.error,
          todos: const <TodoModel>[],
        );
}
