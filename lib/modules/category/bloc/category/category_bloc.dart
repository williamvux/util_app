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
  }

  void _handleLoadingTasks(
    LoadingCategory event,
    Emitter<CategoryState> emit,
  ) {
    final listTasks = GetIt.I<IUBox>().box.values.toList();
    emit(CategoryLoaded(tasks: listTasks));
  }

  void _toggleItemTask(
    ToggleItem event,
    Emitter<CategoryState> emit,
  ) {
    print([29, event.model.title]);
    GetIt.I<IUBox>().box.putAt(event.index, event.model);
    final listTasks = GetIt.I<IUBox>().box.values.toList();
    emit(CategoryLoaded(tasks: listTasks));
  }
}
