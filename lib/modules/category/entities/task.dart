import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:util/models/constant.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
final class TaskModel extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isChecked;

  @HiveField(3)
  String? datetime = DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now());

  TaskModel({
    required this.uuid,
    required this.title,
    required this.isChecked,
    required this.datetime,
  });

  TaskModel copyWith({String? title, bool? isChecked, String? datetime}) =>
      TaskModel(
        uuid: uuid,
        title: title ?? this.title,
        isChecked: isChecked ?? this.isChecked,
        datetime: datetime ?? this.datetime,
      );
}
