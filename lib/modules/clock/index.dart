import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/bootstrap/bloc/orientation/orientation_bloc.dart';
import 'package:util/models/pair.dart';
import 'package:util/models/triple.dart';
import 'package:util/modules/clock/components/clock_picker.dart';
import 'package:util/modules/clock/entities/timer.dart';
import 'package:util/modules/clock/bloc/clock_bloc/clock_bloc.dart';
import 'package:util/modules/clock/enum/index.dart';
import 'package:util/modules/clock/widgets/clock.dart';
import 'package:util/modules/clock/widgets/timer_btn.dart';
import 'package:util/utils/index.dart';

class ClockScreen extends StatefulWidget {
  static const String routeName = 'clock';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const ClockScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  final ReceivePort port = ReceivePort();
  int hour = 0;
  int minute = 0;
  int second = 0;
  Isolate? isolate;
  @override
  void initState() {
    super.initState();
    _setUpPort();
  }

  void _setUpPort() {
    port.listen((pair) {
      context.read<ClockBloc>().add(
            SetupClock(
              timer: TimerEntity(
                timer: pair.first,
                seconds: pair.second,
              ),
            ),
          );
    });
  }

  void _setUpClock(Triple<int, int, int> triple) {
    isolate?.kill();
    final int seconds =
        triple.first * 60 * 60 + triple.second * 60 + triple.third;
    Isolate.spawn(
      (Pair<SendPort, int> pair) {
        int seconds = pair.second;
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
          pair.first
              .send(Pair<String, int>(secondsToHms(seconds: seconds), seconds));
          if (seconds == 0) {
            timer.cancel();
          }
          seconds -= 1;
        });
      },
      Pair<SendPort, int>(
        port.sendPort,
        seconds,
      ),
    ).then((value) {
      isolate = value;
    });
  }

  void _openDialogSetTime() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final boxRadius = BorderRadius.circular(20.0);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: boxRadius,
          ), //this right here
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClockPicker(label: 'HH', arr: arrHH),
                  ClockPicker(label: 'MM', arr: arrMMSS),
                  ClockPicker(label: 'SS', arr: arrMMSS),
                ],
              ),
              const Text('Hello'),
            ],
          ),
        );
      },
    );
  }

  double _calWidthClock({
    required Orientation orientation,
    required Size size,
  }) {
    final width = (switch (orientation) {
      Orientation.landscape => size.height,
      Orientation.portrait => size.width,
    });
    return width - 150;
  }

  @override
  void dispose() {
    port.close();
    isolate?.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrientationBloc, OrientationState>(
      builder: (BuildContext context, OrientationState state) {
        final widthClock = _calWidthClock(
          orientation: state.orientation,
          size: MediaQuery.of(context).size,
        );
        return Scaffold(
          backgroundColor: Colors.blue.shade50,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClockWidget(widthClock: widthClock),
                const SizedBox(height: 50),
                TimerBtn(
                  setUpClock: _setUpClock,
                  openDialogSetTime: _openDialogSetTime,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
