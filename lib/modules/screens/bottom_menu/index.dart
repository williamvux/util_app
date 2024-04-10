import 'package:flutter/material.dart';
import 'package:util/modules/screens/clock/index.dart';

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
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  // Widgets for each tab/screen
  final List<Widget> _widgetOptions = <Widget>[
    Container(),
    const ClockScreen(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _renderIcon(IconData iconMenu) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconMenu,
      ),
      label: "Home",
      activeIcon: Container(
        width: 70,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurple.shade100),
        child: Icon(
          iconMenu,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[300],
        items: <BottomNavigationBarItem>[
          _renderIcon(Icons.home),
          _renderIcon(Icons.watch_later_rounded),
          _renderIcon(Icons.calendar_month),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo[900], // Color for selected item
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      drawerEnableOpenDragGesture: true,
    );
  }
}
