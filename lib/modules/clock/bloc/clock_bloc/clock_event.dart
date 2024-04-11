part of 'clock_bloc.dart';

sealed class ClockEvent extends Equatable {}

final class InitClock extends ClockEvent {
  @override
  List<Object?> get props => [];
}

final class SetupClock extends ClockEvent {
  final TimerEntity timer;

  SetupClock({required this.timer});

  @override
  List<Object?> get props => [timer];
}
