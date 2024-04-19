part of 'change_time_bloc.dart';

final class ChangeTimeEvent extends Equatable {
  final TimeUnit unit;
  final int number;

  const ChangeTimeEvent({required this.number, required this.unit});

  @override
  List<Object> get props => [number, unit];
}
