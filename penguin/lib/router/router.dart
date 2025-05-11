import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Главная страница
        AutoRoute(page: MainRoute.page, initial: true),
        AutoRoute(page: AuthRoute.page, initial: false),

        // Страницы авторизации
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegistrationRoute.page),

        // Вводные экраны (Intro Pages)
        AutoRoute(page: SplashRoute.page),

        // Другие экраны
        AutoRoute(page: PaymentRoute.page),
        AutoRoute(page: GradefulRoute.page),

        // Страницы для BottomNavigationBar
        CustomRoute(
          page: HomeRoute.page,
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 300),
        ),
        CustomRoute(
          page: CatalogRoute.page,
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 300),
        ),
        CustomRoute(
          page: MapRoute.page,
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 300),
        ),
        CustomRoute(
          page: BasketRoute.page,
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 300),
        ),
      ];
}
