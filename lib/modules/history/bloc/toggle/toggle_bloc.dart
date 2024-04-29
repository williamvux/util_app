import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/models/constant.dart';

part 'toggle_event.dart';
part 'toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleBloc() : super(ToggleState(datetime: '', uuid: Constant.uuid())) {
    on<ToggleEvent>((event, emit) {
      emit(ToggleState(
        datetime: event.datetime,
        uuid: DateTime.now().toString(),
      ));
    });
  }
}
