part of 'orientation_bloc.dart';

final class OrientationState extends Equatable {
  final Orientation orientation;

  const OrientationState(this.orientation);

  @override
  List<Object> get props => [orientation];
}
