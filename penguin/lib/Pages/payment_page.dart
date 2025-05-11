import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';

@RoutePage()
class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.cyanAccent,
       appBar: const AppBarWidget(
        leftText: 'ОФОРМЛЕНИЕ',
        rightText: 'ЗАКАЗА',
        showSignOutButton: true,
      ),
    );
  }
}