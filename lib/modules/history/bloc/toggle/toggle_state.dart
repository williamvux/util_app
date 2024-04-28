part of 'toggle_bloc.dart';

final class ToggleState extends Equatable {
  final String uuid;
  final String datetime;

  const ToggleState({required this.datetime, required this.uuid});

  @override
  List<Object> get props => [datetime, uuid];
}
