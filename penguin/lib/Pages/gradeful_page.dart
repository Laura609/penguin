import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/bottom_bar_widget.dart';
import 'package:penguin/router/router.gr.dart';

@RoutePage()
class GradefulPage extends StatelessWidget {
  final String selectedAddress;
  
  const GradefulPage({
    super.key,
    @PathParam() required this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        leftText: 'ОФОРМЛЕНИЕ',
        rightText: 'ЗАКАЗА',
        showSignOutButton: false,
        isBack: false,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Text(
              'СПАСИБО ЗА ЗАКАЗ!',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            Image.asset(
              'assets/penguin.png',
              width: 300,
              height: 300,
            ),

            const SizedBox(height: 20),

            Text(
              'Заказ будет ждать вас по адресу:\n$selectedAddress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  context.router.pushAndPopUntil(
                    const CatalogRoute(),
                    predicate: (_) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(84, 170, 242, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Вернуться в каталог'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}