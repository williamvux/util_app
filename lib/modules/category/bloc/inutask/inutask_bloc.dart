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
    emit(INUTaskLoaded(tasks: GetIt.I<INUBox>().box.values.toList()));
  }

  void _addINUTask(
    AddINUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<INUBox>().box.add(event.model);
    final tasks = List<TaskModel>.from(event.tasks)..add(event.model);
    emit(INUTaskLoaded(tasks: tasks));
  }

  void _deleteAllINUTasks(
    DeleteAllINUTasks event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<INUBox>().box.clear();
    emit(const INUTaskLoaded(tasks: []));
  }

  void _toggleItemINUTask(
    ToggleINUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<INUBox>().box.putAt(event.index, event.model);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks[event.index] = event.model;

    emit(INUTaskLoaded(tasks: tasks));
  }

  void _deleteINUTask(
    DeleteINUTask event,
    Emitter<TaskState> emit,
  ) {
    GetIt.I<INUBox>().box.deleteAt(event.index);

    final tasks = List<TaskModel>.from(event.tasks);
    tasks.removeAt(event.index);

    emit(INUTaskLoaded(tasks: tasks));
  }
}
