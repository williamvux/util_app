import 'package:flutter/cupertino.dart';

class ClockPicker extends StatelessWidget {
  final List<int> arr;
  final String label;
  const ClockPicker({super.key, required this.arr, required this.label});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker.builder(
              childCount: arr.length,
              itemExtent: 40,
              onSelectedItemChanged: (int index) {},
              squeeze: 1.25,
              itemBuilder: (BuildContext context, int index) {
                final strNum =
                    arr[index] < 10 ? '0${arr[index]}' : arr[index].toString();
                return Center(
                  child: Text(
                    strNum,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
