import 'package:flutter/material.dart';
import 'package:util/modules/category/widgets/box_task.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'category';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const CategoryScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final widthEachBox = (MediaQuery.of(context).size.width - 15) / 2;
    final heightEachBox = (MediaQuery.of(context).size.height - 85) / 2;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxTask(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Important\nUrgent',
                boxColor: Colors.red.shade400,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              BoxTask(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Important\nNot Urgent',
                boxColor: Colors.green.shade300,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxTask(
                placeholder: 'Not Important\nUrgent',
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                boxColor: Colors.blue.shade200,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              BoxTask(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Not Important\nNot Urgent',
                boxColor: Colors.amber.shade100,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
