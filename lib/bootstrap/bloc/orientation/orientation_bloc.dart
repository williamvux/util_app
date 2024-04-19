import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orientation_event.dart';
part 'orientation_state.dart';

class OrientationBloc extends Bloc<OrientationEvent, OrientationState> {
  OrientationBloc() : super(const OrientationState(Orientation.portrait)) {
    on<OrientationEvent>((
      OrientationEvent event,
      Emitter<OrientationState> emit,
    ) {
      emit(OrientationState(event.orientation));
    });
  }
}
