import 'package:flutter/material.dart';
import 'package:util/modules/clock/components/circle_clock.dart';
import 'package:util/modules/clock/components/timer.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({
    super.key,
    required this.widthClock,
  });

  final double widthClock;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthClock,
      height: widthClock,
      child: Stack(
        children: [
          CircleClock(widthClock: widthClock),
          const TimerWidget(),
        ],
      ),
    );
  }
}
