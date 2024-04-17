import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Constant {
  static String now([String format = 'HH:mm dd-MM-yyyy']) =>
      DateFormat(format).format(DateTime.now());
  static String uuid() => const Uuid().v4();
}
