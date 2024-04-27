import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/modules/clock/bloc/change_time/change_time_bloc.dart';
import 'package:util/modules/clock/components/clock_picker.dart';
import 'package:util/modules/clock/enum/index.dart';

// ignore: must_be_immutable
class DialogTimePicker extends StatelessWidget {
  int hour = 0;
  int minute = 0;
  int second = 0;

  final BorderRadius boxRadius;
  final void Function({
    required int hour,
    required int minute,
    required int second,
  }) setUpBtnClock;

  DialogTimePicker({super.key, required this.boxRadius, required this.setUpBtnClock});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: boxRadius,
      ), //this right here
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 30, right: 20, left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClockPicker(unit: TimeUnit.HH, arr: arrHH),
                ClockPicker(unit: TimeUnit.MM, arr: arrMMSS),
                ClockPicker(unit: TimeUnit.SS, arr: arrMMSS),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<ChangeTimeBloc, ChangeTimeState>(
                  buildWhen: (
                    ChangeTimeState previous,
                    ChangeTimeState current,
                  ) =>
                      current.unit == TimeUnit.HH,
                  builder: (context, state) {
                    hour = state.number;
                    final strNum =
                        '${state.number < 10 ? '0${state.number}' : state.number.toString()}:';
                    return Text(
                      strNum,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                BlocBuilder<ChangeTimeBloc, ChangeTimeState>(
                  buildWhen: (
                    ChangeTimeState previous,
                    ChangeTimeState current,
                  ) =>
                      current.unit == TimeUnit.MM,
                  builder: (context, state) {
                    minute = state.number;
                    final strNum =
                        '${state.number < 10 ? '0${state.number}' : state.number.toString()}:';
                    return Text(
                      strNum,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                BlocBuilder<ChangeTimeBloc, ChangeTimeState>(
                  buildWhen: (
                    ChangeTimeState previous,
                    ChangeTimeState current,
                  ) =>
                      current.unit == TimeUnit.SS,
                  builder: (context, state) {
                    second = state.number;
                    final strNum = state.number < 10 ? '0${state.number}' : state.number.toString();
                    return Text(
                      strNum,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                setUpBtnClock(hour: hour, minute: minute, second: second);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.edit, size: 20),
              label: const Text('Set'),
            )
          ],
        ),
      ),
    );
  }
}
