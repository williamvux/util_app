import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/bottom_menu/index.dart';
import 'package:util/modules/todolist/entities/todo.dart';

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
    getApplicationDocumentsDirectory().then((Directory directory) {
      Hive
        ..init(directory.path)
        ..registerAdapter(TaskModelAdapter())
        ..registerAdapter(TodoModelAdapter());
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
        return Hive.openBox<TodoModel>(HiveBox.todo.name);
      }).then((Box<TodoModel> box) {
        GetIt.I.registerLazySingleton<TodoBox>(() => TodoBox(box: box));
        return Future.delayed(const Duration(seconds: 1));
      }).then((_) {
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
                'https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_1080,q_100,w_1080/v1/gcs/platform-data-dsc/events/Flutter%20Bird.png'),
          ),
        ),
      ),
    );
  }
}
