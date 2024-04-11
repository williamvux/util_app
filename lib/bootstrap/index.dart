import 'package:flutter/material.dart';
import 'package:util/modules/splash/index.dart';
import 'package:util/router/index.dart';

class UtilApp extends StatelessWidget {
  const UtilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}

Widget bootstrap() {
  return const UtilApp();
}
