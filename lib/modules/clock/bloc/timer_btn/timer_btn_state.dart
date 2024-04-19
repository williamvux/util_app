part of 'timer_btn_bloc.dart';

sealed class TimerBtnState extends Equatable {
  final int hour;
  final int minute;
  final int second;
  final TimeStatus timeStatus;

  const TimerBtnState({
    required this.hour,
    required this.minute,
    required this.second,
    required this.timeStatus,
  });

  @override
  List<Object> get props => [hour, minute, second, timeStatus];
}

final class TimerBtnInitial extends TimerBtnState {
  const TimerBtnInitial({
    super.hour = 0,
    super.minute = 0,
    super.second = 0,
    super.timeStatus = TimeStatus.set,
  });
}

final class TimerBtnSet extends TimerBtnState {
  const TimerBtnSet({
    required super.hour,
    required super.minute,
    required super.second,
    super.timeStatus = TimeStatus.set,
  });
}

final class TimerBtnStart extends TimerBtnState {
  const TimerBtnStart({
    required super.hour,
    required super.minute,
    required super.second,
    super.timeStatus = TimeStatus.start,
  });
}

final class TimerBtnPause extends TimerBtnState {
  const TimerBtnPause({
    required super.hour,
    required super.minute,
    required super.second,
    super.timeStatus = TimeStatus.pause,
  });
}

final class TimerBtnResume extends TimerBtnState {
  const TimerBtnResume({
    required super.hour,
    required super.minute,
    required super.second,
    super.timeStatus = TimeStatus.resume,
  });
}
