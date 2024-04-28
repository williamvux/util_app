part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  final Progress status;
  final Map<String, List<TodoModel>> mapTodo;

  const TodoState({required this.status, required this.mapTodo});

  @override
  List<Object> get props => [status, mapTodo];
}

final class TodoInitial extends TodoState {
  const TodoInitial() : super(status: Progress.initial, mapTodo: const {});
}

final class TodoLoading extends TodoState {
  const TodoLoading() : super(status: Progress.loading, mapTodo: const {});
}

final class TodoLoaded extends TodoState {
  const TodoLoaded({required super.mapTodo}) : super(status: Progress.loaded);
}

final class TodoError extends TodoState {
  const TodoError() : super(status: Progress.error, mapTodo: const {});
}
