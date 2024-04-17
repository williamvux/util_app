import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/bloc/common.dart';
import 'package:util/modules/category/entities/task.dart';

part 'niutask_event.dart';
part 'niutask_state.dart';

class NIUTaskBloc extends Bloc<TaskEvent, TaskState> {
  NIUTaskBloc() : super(const NIUTaskInitial()) {
    on<LoadingNIUTasks>(_handleLoadingNIUTasks);
    on<AddNIUTask>(_addNIUTask);
    on<ToggleNIUTask>(_toggleItemNIUTask);
    on<DeleteAllNIUTasks>(_deleteAllNIUTasks);
    on<DeleteNIUTask>(_deleteNIUTask);
  }
  void _handleLoadingNIUTasks(
    LoadingNIUTasks event,
    Emitter<TaskState> emit,
  ) {
    emit(const NIUTaskLoading());
    emit(NIUTaskLoaded(tasks: GetIt.I<NIUBox>().box.values.toList()));
  }

  void _addNIUTask(
    AddNIUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<NIUBox>().box.add(event.model);
    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    emit(NIUTaskLoaded(tasks: tasks));
  }

  void _deleteAllNIUTasks(
    DeleteAllNIUTasks event,
    Emitter<TaskState> emit,
  ) {
    emit(const NIUTaskLoaded(tasks: []));
  }

  void _toggleItemNIUTask(
    ToggleNIUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<NIUBox>().box.putAt(event.index, event.model);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks[event.index] = event.model;

    emit(NIUTaskLoaded(tasks: tasks));
  }

  void _deleteNIUTask(
    DeleteNIUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<NIUBox>().box.deleteAt(event.index);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks.removeAt(event.index);

    emit(NIUTaskLoaded(tasks: tasks));
  }
}
