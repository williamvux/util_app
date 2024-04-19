import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/components/random_color.dart';
import 'package:util/modules/clock/bloc/clock_bloc/clock_bloc.dart';

class CircleClock extends StatelessWidget {
  final double widthClock;
  const CircleClock({super.key, required this.widthClock});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockBloc, ClockState>(
      buildWhen: (ClockState previous, ClockState current) =>
          current.timer.seconds % 5 == 0,
      builder: (context, state) {
        return Container(
          width: widthClock,
          height: widthClock,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 20,
              color: randColor(),
            ),
          ),
        );
      },
    );
  }
}
