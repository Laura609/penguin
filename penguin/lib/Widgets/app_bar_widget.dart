import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penguin/router/router.gr.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String leftText;
  final String rightText;
  final bool showSignOutButton;
  final Color backgroundColor;
  final Color textColor;
  final bool isBack;

  const AppBarWidget({
    super.key,
    required this.leftText,
    required this.rightText,
    this.showSignOutButton = false,
    this.backgroundColor = const Color.fromRGBO(84, 170, 242, 1),
    this.textColor = Colors.white,
    this.isBack = false,
  });

  double _calculateFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 375) {
      return 20;
    }
    return 24;
  }

@override
Widget build(BuildContext context) {
  final fontSize = _calculateFontSize(context);

  final hasLeftOrRightText = leftText.isNotEmpty || rightText.isNotEmpty;

  return AppBar(
    backgroundColor: backgroundColor,
    leading: isBack
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.router.pop(),
          )
        : null,
    title: Container(
      alignment: Alignment.center,
      child: hasLeftOrRightText
          ? Row(
              mainAxisAlignment:
                  showSignOutButton ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                Text(
                  leftText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Image.asset(
                    'assets/penguin.png',
                    height: 100,
                    width: 70,
                  ),
                ),
                Text(
                  rightText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Image.asset(
                'assets/penguin.png',
                height: 100,
                width: 70,
              ),
            ),
    ),
    centerTitle: true,
    actions: showSignOutButton
        ? [
            IconButton(
              icon: Image.asset(
                'assets/goOut.png',
                height: 24,
                width: 24,
              ),
              onPressed: () => _signOut(context),
            ),
          ]
        : [],
  );
}

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.router.replace(const AuthRoute());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}