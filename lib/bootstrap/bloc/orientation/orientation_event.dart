part of 'orientation_bloc.dart';

final class OrientationEvent extends Equatable {
  final Orientation orientation;

  const OrientationEvent({required this.orientation});

  @override
  List<Object> get props => [orientation];
}
