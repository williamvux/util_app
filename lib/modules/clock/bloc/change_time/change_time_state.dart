part of 'change_time_bloc.dart';

final class ChangeTimeState extends Equatable {
  final TimeUnit unit;
  final int number;

  const ChangeTimeState({required this.number, required this.unit});

  @override
  List<Object> get props => [number, unit];
}
