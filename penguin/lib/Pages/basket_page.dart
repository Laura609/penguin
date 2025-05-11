import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/bottom_bar_widget.dart';

@RoutePage()
class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.cyanAccent,
       appBar: const AppBarWidget(
        leftText: 'ОФОРМИ',
        rightText: 'ЗАКАЗ',
        showSignOutButton: false,
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}