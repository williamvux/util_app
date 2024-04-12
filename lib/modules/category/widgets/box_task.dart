import 'package:flutter/material.dart';

class BoxTask extends StatelessWidget {
  final double widthEachBox;
  final double heightEachBox;
  final String placeholder;
  final Color boxColor;
  final Widget child;

  const BoxTask({
    super.key,
    required this.widthEachBox,
    required this.heightEachBox,
    required this.placeholder,
    required this.boxColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final heightContent = heightEachBox - 10;
    final widthContent = widthEachBox - 10;
    const borderRadius = 2.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: boxColor,
      ),
      width: widthEachBox,
      height: heightEachBox,
      child: Stack(
        children: [
          Center(
            child: Text(
              placeholder,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white30,
              ),
            ),
          ),
          Center(
            child: Container(
              width: widthContent,
              height: heightContent,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: widthContent,
              height: heightContent,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
