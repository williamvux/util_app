import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/enum/index.dart';
import 'package:util/modules/clock/entities/timer.dart';

part 'clock_event.dart';
part 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  ClockBloc() : super(const ClockInitial()) {
    on<SetupClock>(_handleSetupClock);
  }

  FutureOr<void> _handleSetupClock(
    SetupClock event,
    Emitter<ClockState> emit,
  ) {
    emit(ClockLoaded(timer: event.timer));
  }
}
