import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/models/pair.dart';
import 'package:util/models/triple.dart';
import 'package:util/modules/clock/Entities/timer.dart';
import 'package:util/modules/clock/bloc/clock_bloc/clock_bloc.dart';
import 'package:util/modules/clock/widgets/clock.dart';
import 'package:util/utils/index.dart';

class ClockScreen extends StatefulWidget {
  final Orientation direction;
  static const String routeName = 'clock';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const ClockScreen(
        direction: Orientation.portrait,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ClockScreen({super.key, required this.direction});

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

  void _setUpClock(Triple<int, int, int> triple) async {
    isolate?.kill();
    final int seconds =
        triple.first * 60 * 60 + triple.second * 60 + triple.third;
    SetupClock(
      timer: TimerEntity(
        timer: secondsToHms(seconds: seconds),
        seconds: seconds,
      ),
    );
    Isolate value = await Isolate.spawn(
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
    );
    isolate = value;
  }

  @override
  void dispose() {
    port.close();
    isolate?.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthClock = MediaQuery.of(context).size.width - 150;
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClockWidget(widthClock: widthClock),
            const SizedBox(height: 50),
            FloatingActionButton.extended(
              onPressed: () {
                second = 10;
                _setUpClock(Triple(hour, minute, second));
              },
              extendedPadding: const EdgeInsets.symmetric(horizontal: 50),
              icon: const Icon(Icons.timer),
              label: const Text(
                'Start',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
