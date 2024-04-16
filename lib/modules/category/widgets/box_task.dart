import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/enum/index.dart';

class BoxTask extends StatelessWidget {
  final double widthEachBox;
  final double heightEachBox;
  final String placeholder;
  final Color boxColor;
  final Widget child;
  final TypeTask typeTask;
  final void Function({required TypeTask typeTask, required Color color})
      openDialog;
  final void Function() deleteAllTasks;

  const BoxTask({
    super.key,
    required this.widthEachBox,
    required this.heightEachBox,
    required this.placeholder,
    required this.boxColor,
    required this.child,
    required this.deleteAllTasks,
    required this.typeTask,
    required this.openDialog,
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
                color: Colors.black26,
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
          Positioned(
            bottom: 10,
            right: 10,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    openDialog(typeTask: typeTask, color: boxColor);
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (GetIt.I<IUBox>().box.isNotEmpty) {
                      GetIt.I<IUBox>().box.clear();
                      deleteAllTasks();
                    }
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
