import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/entities/task.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryInitial()) {
    on<LoadingCategory>(_handleLoadingTasks);
    on<ToggleItem>(_toggleItemTask);
    on<DeleteAll>(_handleDeleteAll);
  }

  void _handleLoadingTasks(
    LoadingCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());
    await Future.delayed(const Duration(seconds: 5));
    emit(CategoryLoaded(tasks: GetIt.I<IUBox>().box.values.toList()));
  }

  void _handleDeleteAll(
    DeleteAll event,
    Emitter<CategoryState> emit,
  ) {
    emit(const CategoryLoaded(tasks: []));
  }

  void _toggleItemTask(
    ToggleItem event,
    Emitter<CategoryState> emit,
  ) {
    GetIt.I<IUBox>().box.putAt(event.index, event.model);

    emit(CategoryLoaded(tasks: GetIt.I<IUBox>().box.values.toList()));
  }
}
