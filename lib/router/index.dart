import 'package:flutter/material.dart';
import 'package:util/modules/bottom_menu/index.dart';
import 'package:util/modules/category/index.dart';
import 'package:util/modules/clock/index.dart';
import 'package:util/modules/error/index.dart';
import 'package:util/modules/splash/index.dart';
import 'package:util/modules/todolist/index.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case BottomMenu.routeName:
        return BottomMenu.route();
      case ClockScreen.routeName:
        return ClockScreen.route();
      case CategoryScreen.routeName:
        return CategoryScreen.route();
      case TodoScreen.routeName:
        return TodoScreen.route();
      default:
        return ErrorScreen.route();
    }
  }
}
