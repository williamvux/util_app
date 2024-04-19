part of 'timer_btn_bloc.dart';

sealed class TimerBtnEvent extends Equatable {
  const TimerBtnEvent();

  @override
  List<Object> get props => [];
}

final class SetupClock extends TimerBtnEvent {
  final TimeStatus status;
  final int hour;
  final int minute;
  final int second;

  const SetupClock({
    required this.status,
    required this.hour,
    required this.minute,
    required this.second,
  });
}
