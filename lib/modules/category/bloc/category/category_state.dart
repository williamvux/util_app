part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  final Progress status;
  final List<TaskModel> tasks;
  const CategoryState({required this.tasks, required this.status});

  @override
  List<Object> get props => [tasks, status];
}

final class CategoryInitial extends CategoryState {
  const CategoryInitial({
    super.tasks = const <TaskModel>[],
    super.status = Progress.initial,
  });
}

final class CategoryLoading extends CategoryState {
  const CategoryLoading({
    super.tasks = const <TaskModel>[],
    super.status = Progress.loading,
  });
}

final class CategoryLoaded extends CategoryState {
  const CategoryLoaded({
    required super.tasks,
    super.status = Progress.loaded,
  });
}

final class CategoryError extends CategoryState {
  const CategoryError({
    super.tasks = const <TaskModel>[],
    super.status = Progress.error,
  });
}
