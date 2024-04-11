import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/models/pair.dart';
import 'package:util/models/triple.dart';
import 'package:util/modules/clock/Entities/timer.dart';
import 'package:util/modules/clock/bloc/clock_bloc/clock_bloc.dart';
import 'package:util/modules/clock/components/circle_clock.dart';
import 'package:util/modules/clock/components/timer.dart';
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
  Isolate? isolate;
  @override
  void initState() {
    super.initState();
    port.listen((pair) {
      print([35, pair]);
      context.read<ClockBloc>().add(SetupClock(
          timer: TimerEntity(timer: pair.first, seconds: pair.second)));
    });
    Isolate.spawn(
      (Pair<SendPort, Triple<int, int, int>> pair) {
        final timer = pair.second;
        int seconds = timer.first * 60 * 60 + timer.second * 60 + timer.third;
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
          seconds -= 1;
          pair.first
              .send(Pair<String, int>(secondsToHms(seconds: seconds), seconds));
          if (seconds == 0) {
            timer.cancel();
          }
        });
      },
      Pair<SendPort, Triple<int, int, int>>(
        port.sendPort,
        const Triple(0, 1, 0),
      ),
    ).then((Isolate value) {
      isolate = value;
    });
  }

  @override
  void dispose() {
    port.close();
    isolate?.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthClock = MediaQuery.of(context).size.width - 100;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: widthClock,
              height: widthClock,
              child: Stack(
                children: [
                  CircleClock(widthClock: widthClock),
                  const TimerWidget(),
                ],
              ),
            ),
            const SizedBox(height: 50),
            FloatingActionButton.extended(
              onPressed: () {},
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
