// ignore_for_file: constant_identifier_names

import 'package:util/modules/category/typealias/index.dart';

enum TypeTask {
  I_U,
  I_NU,
  NI_U,
  NI_NU,
}

const TTitleTask mapBoxTitle = {
  TypeTask.I_U: 'Important, Urgent',
  TypeTask.I_NU: 'Important, Not Urgent',
  TypeTask.NI_U: 'Not Important, Urgent',
  TypeTask.NI_NU: 'Not Important, Not Urgent',
};
