import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 0)
final class TaskModel extends HiveObject {
  @HiveField(0)
  final String uuid = GetIt.I<Uuid>().v4();

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isChecked = false;

  TaskModel({required this.title});
}
