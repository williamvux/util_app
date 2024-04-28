part of 'toggle_bloc.dart';

final class ToggleEvent extends Equatable {
  final String datetime;

  const ToggleEvent({required this.datetime});

  @override
  List<Object> get props => [datetime];
}
