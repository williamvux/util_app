import 'dart:math';

import 'package:flutter/material.dart';

Color randColor() =>
    Colors.primaries[Random().nextInt(Colors.primaries.length)];
