import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/bottom_bar_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: const AppBarWidget(
        leftText: 'ВЕСЁЛЫЙ',
        rightText: 'ПИНГВИН',
        showSignOutButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Реклама
            Container(
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 4, 40, 1),
              ),
              child: SizedBox(
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Мороженое для ваших улыбок',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Самое натуральное мороженое от нашего пингвина порадует как взрослого, так и ребёнка',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 160,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color.fromRGBO(
                                  0,
                                  4,
                                  40,
                                  1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Заказать',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 220,
                      width: 210,
                      child: Image.asset(
                        'assets/ice_cream_cone.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // История
            SizedBox(
              height: 220,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'История пингвина',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Когда-то давным-давно один весёлый молочник нашёл на берегу океана одинокого пингвина, который был редкостью в тех краях. Местные жители приходили посмотреть на экзотическую птицу и вместе с тем покупали мороженое у того самого молочника. От чего пингвину стало весело и он стал помогать продавать. Даже через 200 лет мы сохранили уникальный рецепт мороженого, которое радует вас по сей день!',
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: SizedBox(
                      height: 219,
                      width: 187,
                      child: Image.asset(
                        'assets/penguin.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
           
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
