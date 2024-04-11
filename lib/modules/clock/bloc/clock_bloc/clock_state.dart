part of 'clock_bloc.dart';

sealed class ClockState extends Equatable {
  final Progress status;
  final TimerEntity timer;

  const ClockState({required this.status, required this.timer});
  @override
  List<Object?> get props => [status, timer];
}

final class ClockInitial extends ClockState {
  const ClockInitial({
    super.status = Progress.initial,
    super.timer = const TimerEntity(timer: '00:00:00', seconds: 0),
  });
}

final class ClockLoading extends ClockState {
  const ClockLoading({
    super.status = Progress.loading,
    super.timer = const TimerEntity(timer: '00:00:00', seconds: 0),
  });
}

final class ClockLoaded extends ClockState {
  const ClockLoaded({
    super.status = Progress.loaded,
    required super.timer,
  });
}

final class ClockError extends ClockState {
  const ClockError({
    super.status = Progress.error,
    super.timer = const TimerEntity(timer: '00:00:00', seconds: 0),
  });
}
