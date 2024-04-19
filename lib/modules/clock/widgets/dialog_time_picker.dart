import 'package:flutter/material.dart';
import 'package:util/modules/clock/components/clock_picker.dart';
import 'package:util/modules/clock/enum/index.dart';

class DialogTimePicker extends StatelessWidget {
  const DialogTimePicker({
    super.key,
    required this.boxRadius,
  });

  final BorderRadius boxRadius;

  @override
  Widget build(BuildContext context) {
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
  }
}
