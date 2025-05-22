import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penguin/router/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router.config(),
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromRGBO(36, 36, 36, 1),
            primaryColor: const Color.fromRGBO(84, 170, 242, 1),
            useMaterial3: true,
          ),
          // Обязательно передай child от ScreenUtilInit
        );
      },
    );
  }
}