part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class LoadingCategory extends CategoryEvent {
  const LoadingCategory();

  @override
  List<Object> get props => [];
}

final class AddCategory extends CategoryEvent {
  final TaskModel model;
  const AddCategory({required this.model});

  @override
  List<Object> get props => [model];
}

final class ToggleItem extends CategoryEvent {
  final TaskModel model;
  final int index;

  const ToggleItem({required this.model, required this.index});

  @override
  List<Object> get props => [model, index];
}
