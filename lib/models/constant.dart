import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Constant {
  static String now() =>
      DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now());
  static String uuid() => const Uuid().v4();
}
