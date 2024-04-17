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
    emit(IUTaskLoaded(tasks: GetIt.I<IUBox>().box.values.toList()));
  }

  void _addIUTask(
    AddIUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<IUBox>().box.add(event.model);
    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    emit(IUTaskLoaded(tasks: tasks));
  }

  void _handleDeleteAllIUTasks(
    DeleteAllIUTasks event,
    Emitter<TaskState> emit,
  ) {
    emit(const IUTaskLoaded(tasks: []));
  }

  void _toggleItemIUTask(
    ToggleIUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<IUBox>().box.putAt(event.index, event.model);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks[event.index] = event.model;

    emit(IUTaskLoaded(tasks: tasks));
  }

  void _deleteIUTask(
    DeleteIUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<IUBox>().box.deleteAt(event.index);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks.removeAt(event.index);

    emit(IUTaskLoaded(tasks: tasks));
  }
}
