import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/modules/clock/enum/index.dart';

part 'timer_btn_event.dart';
part 'timer_btn_state.dart';

class TimerBtnBloc extends Bloc<TimerBtnEvent, TimerBtnState> {
  TimerBtnBloc() : super(const TimerBtnInitial()) {
    on<SetupClock>((SetupClock event, Emitter<TimerBtnState> emit) {
      // TODO: implement event handler
    });
  }
}
