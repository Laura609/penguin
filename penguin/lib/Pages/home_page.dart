import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/bottom_bar_widget.dart';
import 'package:penguin/Widgets/ice/ice_cream_group_list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              padding: EdgeInsets.only(left: 75.w),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 4, 40, 1),
              ),
              child: SizedBox(
                height: 500.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50.h),
                          Text(
                            'Мороженое для ваших улыбок',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Text(
                            'Самое натуральное мороженое от нашего пингвина порадует как взрослого, так и ребёнка',
                            style: TextStyle(color: Colors.white, fontSize: 25.sp),
                          ),
                          SizedBox(height: 37.5.h),
                          SizedBox(
                            width: 400.w,
                            height: 75.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color.fromRGBO(0, 4, 40, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Заказать',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 550.h,
                      width: 525.w,
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
              height: 590.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 75.w, top: 37.5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'История пингвина',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 45.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Когда-то давным-давно один весёлый молочник нашёл на берегу океана одинокого пингвина, который был редкостью в тех краях. Местные жители приходили посмотреть на экзотическую птицу и вместе с тем покупали мороженое у того самого молочника. От чего пингвину стало весело и он стал помогать продавать. Даже через 200 лет мы сохранили уникальный рецепт мороженого, которое радует вас по сей день!',
                            style: TextStyle(color: Colors.black, fontSize: 25.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: SizedBox(
                      height: 547.5.h,
                      width: 467.5.w,
                      child: Image.asset(
                        'assets/penguin.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 40.h, bottom: 60.h, left: 35.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      'Популярное мороженое',
                      style: TextStyle(
                        fontSize: 45.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 37.5.h),
                  const IceCreamGroupList(groupName: 'election_client'),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}