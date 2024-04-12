import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/gen_id.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/bottom_menu/index.dart';
import 'package:uuid/uuid.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const SplashScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final appDocumentDirectory = Directory.current;
      Hive
        ..init(appDocumentDirectory.path)
        ..registerAdapter(TaskModelAdapter());
      Future.wait<Box<TaskModel>>([
        Hive.openBox(HiveBox.iu.name),
        Hive.openBox(HiveBox.inu.name),
        Hive.openBox(HiveBox.niu.name),
        Hive.openBox(HiveBox.ninu.name),
      ]).then((List<Box<TaskModel>> boxes) {
        GetIt.I.registerLazySingleton<IUBox>(() => IUBox(box: boxes[0]));
        GetIt.I.registerLazySingleton<INUBox>(() => INUBox(box: boxes[1]));
        GetIt.I.registerLazySingleton<NIUBox>(() => NIUBox(box: boxes[2]));
        GetIt.I.registerLazySingleton<NINUBox>(() => NINUBox(box: boxes[3]));
        Navigator.of(context).pushNamed(BottomMenu.routeName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 100,
            height: 1000,
            child: Image.network(
                'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/09/instagram-image-size.jpg'),
          ),
        ),
      ),
    );
  }
}
