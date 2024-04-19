import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/bootstrap/bloc/orientation/orientation_bloc.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  return BlocProvider(
    create: (context) => OrientationBloc(),
    child: const UtilApp(),
  );
}
