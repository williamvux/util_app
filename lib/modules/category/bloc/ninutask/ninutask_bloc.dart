import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/bloc/common.dart';
import 'package:util/modules/category/entities/task.dart';

part 'ninutask_event.dart';
part 'ninutask_state.dart';

class NINUTaskBloc extends Bloc<TaskEvent, TaskState> {
  NINUTaskBloc() : super(const NINUTaskInitial()) {
    on<LoadingNINUTasks>(_handleLoadingNINUTasks);
    on<AddNINUTask>(_addNINUTask);
    on<ToggleNINUTask>(_toggleItemNINUTask);
    on<DeleteAllNINUTasks>(_deleteAllNINUTasks);
    on<DeleteNINUTask>(_deleteNINUTask);
  }
  void _handleLoadingNINUTasks(
    LoadingNINUTasks event,
    Emitter<TaskState> emit,
  ) {
    emit(const NINUTaskLoading());
    emit(NINUTaskLoaded(tasks: GetIt.I<NINUBox>().box.values.toList()));
  }

  void _addNINUTask(
    AddNINUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<NINUBox>().box.add(event.model);
    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    emit(NINUTaskLoaded(tasks: tasks));
  }

  void _deleteAllNINUTasks(
    DeleteAllNINUTasks event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<NINUBox>().box.clear();
    emit(const NINUTaskLoaded(tasks: []));
  }

  void _toggleItemNINUTask(
    ToggleNINUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<NINUBox>().box.putAt(event.index, event.model);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks[event.index] = event.model;

    emit(NINUTaskLoaded(tasks: tasks));
  }

  void _deleteNINUTask(
    DeleteNINUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<NINUBox>().box.deleteAt(event.index);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks.removeAt(event.index);

    emit(NINUTaskLoaded(tasks: tasks));
  }
}
