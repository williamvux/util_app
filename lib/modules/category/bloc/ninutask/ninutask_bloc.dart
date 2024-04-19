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
    Future.microtask(() {
      final List<TaskModel> tasks = GetIt.I<NINUBox>().box.values.toList();
      print(GetIt.I<NINUBox>().box.keys);
      final sortedTasks = sortTasks(tasks: tasks);
      emit(NINUTaskLoaded(tasks: sortedTasks));
    });
  }

  void _addNINUTask(
    AddNINUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NINUBox>().box.put(event.model.uuid, event.model);

    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    final sortedTasks = sortTasks(tasks: tasks);

    emit(NINUTaskLoaded(tasks: sortedTasks));
  }

  void _deleteAllNINUTasks(
    DeleteAllNINUTasks event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NINUBox>().box.clear();

    emit(const NINUTaskLoaded(tasks: []));
  }

  void _toggleItemNINUTask(
    ToggleNINUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NINUBox>().box.put(event.model.uuid, event.model);

    final tasks = GetIt.I<NINUBox>().box.values.toList();
    final sortedTasks = sortTasks(tasks: tasks);

    emit(NINUTaskLoaded(tasks: sortedTasks));
  }

  void _deleteNINUTask(
    DeleteNINUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<NINUBox>().box.delete(event.task.uuid);

    List<TaskModel> tasks = List<TaskModel>.from(event.tasks);
    final sortedTasks = sortTasks(
        tasks: tasks
            .where((TaskModel task) => task.uuid != event.task.uuid)
            .toList());

    emit(NINUTaskLoaded(tasks: sortedTasks));
  }
}
