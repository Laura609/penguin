import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/router/router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.router.replace(const AuthRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 4, 40, 1),
      body: Stack(
        children: [
          // Top image
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.26,
              child: Image.asset(
                'assets/milkUp.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // First text
          Positioned(
            top: screenHeight * 0.28,
            left: screenWidth * 0.1,
            child: Text(
              'ВЕСЕЛЫЙ',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          // Penguin image
          Positioned(
            top: screenHeight * 0.35,
            left: (screenWidth - screenWidth * 0.7) / 2,
            child: SizedBox(
              width: screenWidth * 0.7,
              height: screenHeight * 0.35,
              child: Image.asset(
                'assets/penguin.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Second text
          Positioned(
            top: screenHeight * 0.70,
            left: (screenWidth - screenWidth * 0.4) / 2,
            child: Text(
              'ПИНГВИН',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          // Bottom image
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.37,
              child: Image.asset(
                'assets/milkDown.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}