import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/constant.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/todolist/entities/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial()) {
    on<LoadMapTodo>((LoadMapTodo event, Emitter<TodoState> emit) async {
      emit(const TodoLoading());
      await Future.delayed(const Duration(seconds: 1));
      final mapTodo = <String, List<TodoModel>>{};
      for (var todo in GetIt.I<TodoBox>().box.values) {
        if (mapTodo.containsKey(todo.datetime)) {
          mapTodo[todo.datetime]!.add(todo);
        } else {
          mapTodo[todo.datetime ?? Constant.now('dd-MM-yyyy')] = [todo];
        }
      }
      emit(TodoLoaded(mapTodo: mapTodo));
    });
  }
}
