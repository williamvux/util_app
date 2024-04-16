import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';

part 'category_event.dart';
part 'category_state.dart';

class IUTaskBloc extends Bloc<IUTaskEvent, IUTaskState> {
  IUTaskBloc() : super(const IUTaskInitial()) {
    on<LoadingCategory>(_handleLoadingTasks);
    on<ToggleItem>(_toggleItemTask);
    on<DeleteAll>(_handleDeleteAll);
  }

  void _handleLoadingTasks(
    LoadingCategory event,
    Emitter<IUTaskState> emit,
  ) async {
    emit(const IUTaskLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(IUTaskLoaded(tasks: GetIt.I<IUBox>().box.values.toList()));
  }

  void _handleDeleteAll(
    DeleteAll event,
    Emitter<IUTaskState> emit,
  ) {
    emit(const IUTaskLoaded(tasks: []));
  }

  void _toggleItemTask(
    ToggleItem event,
    Emitter<IUTaskState> emit,
  ) {
    GetIt.I<IUBox>().box.putAt(event.index, event.model);

    emit(IUTaskLoaded(tasks: GetIt.I<IUBox>().box.values.toList()));
  }
}
