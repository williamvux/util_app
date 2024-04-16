part of 'category_bloc.dart';

sealed class IUTaskEvent extends Equatable {
  const IUTaskEvent();

  @override
  List<Object> get props => [];
}

final class LoadingCategory extends IUTaskEvent {
  final TypeTask type;
  const LoadingCategory({required this.type});

  @override
  List<Object> get props => [type];
}

final class AddCategory extends IUTaskEvent {
  final TaskModel model;
  final TypeTask type;
  const AddCategory({required this.model, required this.type});

  @override
  List<Object> get props => [model, type];
}

final class ToggleItem extends IUTaskEvent {
  final TaskModel model;
  final int index;
  final TypeTask type;

  const ToggleItem({
    required this.model,
    required this.index,
    required this.type,
  });

  @override
  List<Object> get props => [model, index, type];
}

final class DeleteAll extends IUTaskEvent {
  final TypeTask type;

  const DeleteAll({required this.type});

  @override
  List<Object> get props => [type];
}
