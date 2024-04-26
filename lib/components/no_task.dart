import 'dart:math';

import 'package:flutter/material.dart';

class NoTask extends StatefulWidget {
  final Color color;
  const NoTask({super.key, this.color = Colors.white});

  @override
  State<NoTask> createState() => _NoTaskState();
}

class _NoTaskState extends State<NoTask> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: Random().nextInt(3) + 2),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedIcon(
            icon: AnimatedIcons.list_view,
            progress: animation,
            color: widget.color,
            semanticLabel: 'Empty',
          ),
          const SizedBox(height: 10),
          Text(
            'There is no task!',
            style: TextStyle(
              color: widget.color,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
