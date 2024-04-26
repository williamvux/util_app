import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/bootstrap/bloc/orientation/orientation_bloc.dart';
import 'package:util/modules/category/bloc/inutask/inutask_bloc.dart';
import 'package:util/modules/category/bloc/iutask/iutask_bloc.dart';
import 'package:util/modules/category/bloc/ninutask/ninutask_bloc.dart';
import 'package:util/modules/category/bloc/niutask/niutask_bloc.dart';
import 'package:util/modules/category/index.dart';
import 'package:util/modules/clock/bloc/clock_bloc/clock_bloc.dart';
import 'package:util/modules/clock/bloc/timer_btn/timer_btn_bloc.dart';
import 'package:util/modules/clock/index.dart';

class BottomMenu extends StatelessWidget {
  static const String routeName = 'bottom_menu';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const BottomMenu(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuPage();
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  // Widgets for each tab/screen
  List<Widget> _widgetOptions() => <Widget>[
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => IUTaskBloc()),
            BlocProvider(create: (context) => INUTaskBloc()),
            BlocProvider(create: (context) => NIUTaskBloc()),
            BlocProvider(create: (context) => NINUTaskBloc()),
          ],
          child: const CategoryScreen(),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ClockBloc()),
            BlocProvider(create: (context) => TimerBtnBloc()),
          ],
          child: const ClockScreen(),
        ),
        Container(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _renderIcon(IconData iconMenu) {
    return BottomNavigationBarItem(
      icon: Icon(iconMenu),
      label: "Home",
      activeIcon: Icon(iconMenu, size: 25),
    );
  }

  double sizeBottomBar({required TargetPlatform platform}) {
    return switch (platform) {
      TargetPlatform.iOS => 80,
      TargetPlatform.android => 60,
      _ => 60
    };
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      BuildContext context,
      BoxConstraints constraints,
    ) {
      final Orientation direction = constraints.maxHeight > constraints.maxWidth
          ? Orientation.portrait
          : Orientation.landscape;
      context
          .read<OrientationBloc>()
          .add(OrientationEvent(orientation: direction));
      final platform = Theme.of(context).platform;
      return Scaffold(
        body: _widgetOptions().elementAt(_selectedIndex),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: direction == Orientation.portrait ? sizeBottomBar(platform: platform) : 0,
          padding: const EdgeInsets.all(0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey[300],
            items: <BottomNavigationBarItem>[
              _renderIcon(Icons.category_rounded),
              _renderIcon(Icons.av_timer_rounded),
              _renderIcon(Icons.task_alt),
            ],
            iconSize: 20,
            enableFeedback: true,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.indigo[900], // Color for selected item
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
        drawerEnableOpenDragGesture: true,
      );
    });
  }
}
