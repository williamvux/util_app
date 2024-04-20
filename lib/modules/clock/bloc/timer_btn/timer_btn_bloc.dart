import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/modules/clock/enum/index.dart';

part 'timer_btn_event.dart';
part 'timer_btn_state.dart';

class TimerBtnBloc extends Bloc<TimerBtnEvent, TimerBtnState> {
  TimerBtnBloc() : super(const TimerBtnInitial()) {
    on<SetupTimeClock>((SetupTimeClock event, Emitter<TimerBtnState> emit) {
      switch (event.status) {
        case TimeStatus.start:
          emit(TimerBtnStart(hour: event.hour, minute: event.minute, second: event.second));
          break;
        case TimeStatus.set:
          emit(const TimerBtnSet(hour: 0, minute: 0, second: 0));
          break;
        case TimeStatus.pause:
          emit(TimerBtnPause(hour: event.hour, minute: event.minute, second: event.second));
          break;
        case TimeStatus.resume:
          emit(TimerBtnResume(hour: event.hour, minute: event.minute, second: event.second));
          break;
      }
    });
  }
}
