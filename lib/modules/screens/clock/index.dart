import 'package:flutter/material.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});
  static const String routeName = 'clock';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const ClockScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widthClock = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: widthClock,
              height: widthClock,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 10,
                  color: Colors.amber,
                ),
              ),
              child: const Center(child: Text('Clock')),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {},
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
