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
    Future.microtask(() {
      final List<TaskModel> tasks = GetIt.I<NIUBox>().box.values.toList();
      print(GetIt.I<NIUBox>().box.keys);
      final sortedTasks = sortTasks(tasks: tasks);
      emit(NIUTaskLoaded(tasks: sortedTasks));
    });
  }

  void _addNIUTask(
    AddNIUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NIUBox>().box.put(event.model.uuid, event.model);

    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    final sortedTasks = sortTasks(tasks: tasks);

    emit(NIUTaskLoaded(tasks: sortedTasks));
  }

  void _deleteAllNIUTasks(
    DeleteAllNIUTasks event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NIUBox>().box.clear();
    emit(const NIUTaskLoaded(tasks: []));
  }

  void _toggleItemNIUTask(
    ToggleNIUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NIUBox>().box.put(event.model.uuid, event.model);

    final tasks = GetIt.I<NIUBox>().box.values.toList();
    final sortedTasks = sortTasks(tasks: tasks);

    emit(NIUTaskLoaded(tasks: sortedTasks));
  }

  void _deleteNIUTask(
    DeleteNIUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NIUBox>().box.delete(event.task.uuid);

    List<TaskModel> tasks = List<TaskModel>.from(event.tasks);
    final sortedTasks = sortTasks(
        tasks: tasks
            .where((TaskModel task) => task.uuid != event.task.uuid)
            .toList());

    emit(NIUTaskLoaded(tasks: sortedTasks));
  }
}
