// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:util/modules/clock/entities/time_label.dart';
import 'package:util/modules/clock/typealias/index.dart';

enum TimeStatus { set, start, pause, resume }

enum TimeUnit { HH, MM, SS }

const MapTimeLbl mapTimeLabel = {
  TimeStatus.set: TimeLabel(icon: Icon(Icons.edit), label: 'SET'),
  TimeStatus.start: TimeLabel(icon: Icon(Icons.start), label: 'START'),
  TimeStatus.pause: TimeLabel(icon: Icon(Icons.pause), label: 'PAUSE'),
  TimeStatus.resume: TimeLabel(icon: Icon(Icons.stop), label: 'RESUME'),
};

final List<int> arrHH = List<int>.generate(
  24,
  (int index) => index,
  growable: false,
);

final List<int> arrMMSS = List<int>.generate(60, (int index) => index);
