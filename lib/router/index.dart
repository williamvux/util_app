import 'package:flutter/material.dart';
import 'package:util/modules/screens/error/index.dart';
import 'package:util/modules/screens/splash/index.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      default:
        return ErrorScreen.route();
    }
  }
}
