import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/bloc/common.dart';
import 'package:util/modules/category/entities/task.dart';

part 'iutask_event.dart';
part 'iutask_state.dart';

class IUTaskBloc extends Bloc<TaskEvent, TaskState> {
  IUTaskBloc() : super(const IUTaskInitial()) {
    on<LoadingIUTasks>(_handleLoadingIUTasks);
    on<AddIUTask>(_addIUTask);
    on<ToggleIUTask>(_toggleItemIUTask);
    on<DeleteAllIUTasks>(_handleDeleteAllIUTasks);
    on<DeleteIUTask>(_deleteIUTask);
  }

  void _handleLoadingIUTasks(
    LoadingIUTasks event,
    Emitter<TaskState> emit,
  ) {
    emit(const IUTaskLoading());
    Future.microtask(() {
      final List<TaskModel> tasks = GetIt.I<IUBox>().box.values.toList();
      print(GetIt.I<IUBox>().box.keys);
      final sortedTasks = sortTasks(tasks: tasks);
      emit(IUTaskLoaded(tasks: sortedTasks));
    });
  }

  void _addIUTask(
    AddIUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<IUBox>().box.put(event.model.uuid, event.model);

    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    final sortedTask = sortTasks(tasks: tasks);

    emit(IUTaskLoaded(tasks: sortedTask));
  }

  void _handleDeleteAllIUTasks(
    DeleteAllIUTasks event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<IUBox>().box.clear();
    emit(const IUTaskLoaded(tasks: []));
  }

  void _toggleItemIUTask(
    ToggleIUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<IUBox>().box.put(event.model.uuid, event.model);

    final tasks = GetIt.I<IUBox>().box.values.toList();
    final sortedTasks = sortTasks(tasks: tasks);

    emit(IUTaskLoaded(tasks: sortedTasks));
  }

  void _deleteIUTask(
    DeleteIUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<IUBox>().box.delete(event.task.uuid);

    List<TaskModel> tasks = List<TaskModel>.from(event.tasks);
    final sortedTask = sortTasks(
        tasks: tasks
            .where((TaskModel task) => task.uuid != event.task.uuid)
            .toList());

    emit(IUTaskLoaded(tasks: sortedTask));
  }
}
