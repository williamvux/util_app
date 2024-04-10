import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  static const String routeName = 'error';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const ErrorScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}