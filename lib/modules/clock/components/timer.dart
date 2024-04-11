import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/components/gradient_text.dart';
import 'package:util/components/random_color.dart';
import 'package:util/enum/index.dart';
import 'package:util/modules/clock/bloc/clock_bloc/clock_bloc.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ClockBloc, ClockState>(
        builder: (BuildContext context, ClockState state) {
          if (state.status == Progress.loaded) {
            return GradientText(
              state.timer.timer,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              gradient: LinearGradient(colors: [
                randColor(),
                randColor(),
              ]),
            );
          } else {
            return const GradientText(
              '00:00:00',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              gradient: LinearGradient(colors: [
                Colors.purpleAccent,
                Colors.amberAccent,
              ]),
            );
          }
        },
      ),
    );
  }
}
