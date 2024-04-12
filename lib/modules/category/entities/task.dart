import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
final class TaskModel extends HiveObject {
  @HiveField(0)
  final String uuid = const Uuid().v4();

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isChecked = false;

  TaskModel({required this.title});
}
