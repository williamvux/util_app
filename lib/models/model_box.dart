import 'package:hive/hive.dart';
import 'package:util/models/task.dart';

sealed class BoxModel {
  final Box<TaskModel> box;

  BoxModel({required this.box});
}

final class IUBox extends BoxModel {
  IUBox({required super.box});
}

final class INUBox extends BoxModel {
  INUBox({required super.box});
}

final class NIUBox extends BoxModel {
  NIUBox({required super.box});
}

final class NINUBox extends BoxModel {
  NINUBox({required super.box});
}
