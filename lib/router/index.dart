import 'package:flutter/material.dart';
import 'package:util/modules/screens/bottom_menu/index.dart';
import 'package:util/modules/screens/clock/index.dart';
import 'package:util/modules/screens/error/index.dart';
import 'package:util/modules/screens/splash/index.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case BottomMenu.routeName:
        return BottomMenu.route();
      case ClockScreen.routeName:
        return ClockScreen.route();
      default:
        return ErrorScreen.route();
    }
  }
}
