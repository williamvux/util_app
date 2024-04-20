import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/models/triple.dart';
import 'package:util/modules/clock/bloc/timer_btn/timer_btn_bloc.dart';
import 'package:util/modules/clock/enum/index.dart';

class TimerBtn extends StatelessWidget {
  final void Function(Triple<int, int, int> triple) setUpClock;
  final void Function() openDialogSetTime;
  const TimerBtn({
    super.key,
    required this.setUpClock,
    required this.openDialogSetTime,
  });

  void Function() func(TimerBtnState state) => switch (state.timeStatus) {
        TimeStatus.start => () {
            setUpClock(Triple(state.hour, state.minute, state.second));
          },
        TimeStatus.pause => () {
            setUpClock(Triple(state.hour, state.minute, state.second));
          },
        TimeStatus.set => openDialogSetTime,
        TimeStatus.resume => () {
            setUpClock(Triple(state.hour, state.minute, state.second));
          },
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBtnBloc, TimerBtnState>(
      builder: (context, state) {
        final btn = mapTimeLabel[state.timeStatus]!;
        print([20, 'Print check re-render', btn.label]);

        return FloatingActionButton.extended(
          onPressed: func(state),
          extendedPadding: const EdgeInsets.symmetric(horizontal: 50),
          icon: btn.icon,
          label: Text(
            btn.label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
