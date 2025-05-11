import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:penguin/router/router.gr.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<String> _iconPaths = [
    'assets/btn1.png',
    'assets/btn2.png',
    'assets/btn3.png',
    'assets/btn4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(84, 170, 242, 1),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(_iconPaths[0], width: 24, height: 24),
          label: "Главная",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(_iconPaths[1], width: 24, height: 24),
          label: "Каталог",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(_iconPaths[2], width: 24, height: 24),
          label: "Карта",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(_iconPaths[3], width: 24, height: 24),
          label: "корзина",
        ),
      ],
      onTap: (int index) {
        if (index == _selectedIndex) return;

        setState(() {
          _selectedIndex = index;
        });

        _navigateToRoute(index);
      },
    );
  }

  void _navigateToRoute(int index) {
    switch (index) {
      case 0:
        context.replaceRoute(const HomeRoute());
        break;
      case 1:
        context.replaceRoute(const CatalogRoute());
        break;
      case 2:
        context.replaceRoute(MapRoute());
        break;
      case 3:
        context.replaceRoute(const BasketRoute());
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    final currentRoute = context.router.current.name;
    if (currentRoute == HomeRoute.name) {
      _selectedIndex = 0;
    } else if (currentRoute == CatalogRoute.name) {
      _selectedIndex = 1;
    } else if (currentRoute == MapRoute.name) {
      _selectedIndex = 2;
    } else if (currentRoute == BasketRoute.name) {
      _selectedIndex = 3;
    }
  }
}
