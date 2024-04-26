import 'package:flutter/material.dart';
import 'package:util/modules/clock/entities/time_label.dart';

class TimerBtn extends StatelessWidget {
  final void Function() onPressed;
  final TimeLabel btn;
  const TimerBtn({super.key, required this.onPressed, required this.btn});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 50),
      icon: btn.icon,
      label: Text(
        btn.label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
