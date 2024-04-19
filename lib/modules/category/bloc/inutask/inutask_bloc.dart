import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/bloc/common.dart';
import 'package:util/modules/category/entities/task.dart';

part 'inutask_event.dart';
part 'inutask_state.dart';

class INUTaskBloc extends Bloc<TaskEvent, TaskState> {
  INUTaskBloc() : super(const INUTaskInitial()) {
    on<LoadingINUTasks>(_handleLoadingINUTasks);
    on<AddINUTask>(_addINUTask);
    on<ToggleINUTask>(_toggleItemINUTask);
    on<DeleteAllINUTasks>(_deleteAllINUTasks);
    on<DeleteINUTask>(_deleteINUTask);
  }
  void _handleLoadingINUTasks(
    LoadingINUTasks event,
    Emitter<TaskState> emit,
  ) {
    emit(const INUTaskLoading());
    Future.microtask(() {
      final List<TaskModel> tasks = GetIt.I<INUBox>().box.values.toList();
      print(GetIt.I<INUBox>().box.keys);
      final sortedTasks = sortTasks(tasks: tasks);
      emit(INUTaskLoaded(tasks: sortedTasks));
    });
  }

  void _addINUTask(
    AddINUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<INUBox>().box.put(event.model.uuid, event.model);

    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    final sortedTask = sortTasks(tasks: tasks);

    emit(INUTaskLoaded(tasks: sortedTask));
  }

  void _deleteAllINUTasks(
    DeleteAllINUTasks event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<INUBox>().box.clear();
    emit(const INUTaskLoaded(tasks: []));
  }

  void _toggleItemINUTask(
    ToggleINUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<INUBox>().box.put(event.model.uuid, event.model);

    final tasks = GetIt.I<INUBox>().box.values.toList();
    final sortedTasks = sortTasks(tasks: tasks);

    emit(INUTaskLoaded(tasks: sortedTasks));
  }

  void _deleteINUTask(
    DeleteINUTask event,
    Emitter<TaskState> emit,
  ) async {
    await GetIt.I<INUBox>().box.delete(event.task.uuid);

    List<TaskModel> tasks = List<TaskModel>.from(event.tasks);
    final sortedTasks = sortTasks(
        tasks: tasks
            .where((TaskModel task) => task.uuid != event.task.uuid)
            .toList());

    emit(INUTaskLoaded(tasks: sortedTasks));
  }
}
