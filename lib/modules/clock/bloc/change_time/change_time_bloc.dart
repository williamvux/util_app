import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/modules/clock/enum/index.dart';

part 'change_time_event.dart';
part 'change_time_state.dart';

class ChangeTimeBloc extends Bloc<ChangeTimeEvent, ChangeTimeState> {
  ChangeTimeBloc()
      : super(const ChangeTimeState(unit: TimeUnit.SS, number: 0)) {
    on<ChangeTimeEvent>((ChangeTimeEvent event, Emitter<ChangeTimeState> emit) {
      emit(ChangeTimeState(number: event.number, unit: event.unit));
    });
  }
}
