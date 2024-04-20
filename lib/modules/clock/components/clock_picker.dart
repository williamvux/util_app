import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/modules/clock/bloc/change_time/change_time_bloc.dart';
import 'package:util/modules/clock/enum/index.dart';

class ClockPicker extends StatelessWidget {
  final List<int> arr;
  final TimeUnit unit;
  const ClockPicker({super.key, required this.arr, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          Text(
            unit.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                context.read<ChangeTimeBloc>().add(ChangeTimeEvent(number: index, unit: unit));
              },
              squeeze: 1.25,
              looping: true,
              children: arr.map((int index) {
                final strNum = arr[index] < 10 ? '0${arr[index]}' : arr[index].toString();
                return Center(
                  child: Text(
                    strNum,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
