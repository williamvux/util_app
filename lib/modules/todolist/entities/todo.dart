import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
final class TodoModel extends HiveObject {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isChecked;

  @HiveField(3)
  final String type;

  @HiveField(4)
  String? datetime = DateFormat("dd-MM-yyyy").format(DateTime.now());

  TodoModel({
    required this.uuid,
    required this.title,
    required this.type,
    required this.isChecked,
    required this.datetime,
  });

  TodoModel copyWith({
    String? title,
    String? type,
    bool? isChecked,
    String? datetime,
  }) =>
      TodoModel(
        uuid: uuid,
        title: title ?? this.title,
        type: type ?? this.type,
        isChecked: isChecked ?? this.isChecked,
        datetime: datetime ?? this.datetime,
      );
}
