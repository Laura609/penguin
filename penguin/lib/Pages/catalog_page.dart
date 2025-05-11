import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/bottom_bar_widget.dart';

@RoutePage()
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
       appBar: const AppBarWidget(
        leftText: '',
        rightText: '',
        showSignOutButton: false,
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}