// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:penguin/Pages/auth_page.dart' as _i1;
import 'package:penguin/Pages/basket_page.dart' as _i2;
import 'package:penguin/Pages/catalog_page.dart' as _i3;
import 'package:penguin/Pages/gradeful_page.dart' as _i4;
import 'package:penguin/Pages/home_page.dart' as _i5;
import 'package:penguin/Pages/login_page.dart' as _i6;
import 'package:penguin/Pages/main_page.dart' as _i7;
import 'package:penguin/Pages/map_page.dart' as _i8;
import 'package:penguin/Pages/payment_page.dart' as _i9;
import 'package:penguin/Pages/registration_page.dart' as _i10;
import 'package:penguin/Pages/splash_screen.dart' as _i11;

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i12.PageRouteInfo<void> {
  const AuthRoute({List<_i12.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthPage();
    },
  );
}

/// generated route for
/// [_i2.BasketPage]
class BasketRoute extends _i12.PageRouteInfo<void> {
  const BasketRoute({List<_i12.PageRouteInfo>? children})
    : super(BasketRoute.name, initialChildren: children);

  static const String name = 'BasketRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.BasketPage();
    },
  );
}

/// generated route for
/// [_i3.CatalogPage]
class CatalogRoute extends _i12.PageRouteInfo<void> {
  const CatalogRoute({List<_i12.PageRouteInfo>? children})
    : super(CatalogRoute.name, initialChildren: children);

  static const String name = 'CatalogRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.CatalogPage();
    },
  );
}

/// generated route for
/// [_i4.GradefulPage]
class GradefulRoute extends _i12.PageRouteInfo<void> {
  const GradefulRoute({List<_i12.PageRouteInfo>? children})
    : super(GradefulRoute.name, initialChildren: children);

  static const String name = 'GradefulRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.GradefulPage();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomePage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i13.Key? key,
    required _i13.VoidCallback showRegisterPage,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, showRegisterPage: showRegisterPage),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return _i6.LoginPage(
        key: args.key,
        showRegisterPage: args.showRegisterPage,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.showRegisterPage});

  final _i13.Key? key;

  final _i13.VoidCallback showRegisterPage;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, showRegisterPage: $showRegisterPage}';
  }
}

/// generated route for
/// [_i7.MainPage]
class MainRoute extends _i12.PageRouteInfo<void> {
  const MainRoute({List<_i12.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.MainPage();
    },
  );
}

/// generated route for
/// [_i8.MapPage]
class MapRoute extends _i12.PageRouteInfo<void> {
  const MapRoute({List<_i12.PageRouteInfo>? children})
    : super(MapRoute.name, initialChildren: children);

  static const String name = 'MapRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.MapPage();
    },
  );
}

/// generated route for
/// [_i9.PaymentPage]
class PaymentRoute extends _i12.PageRouteInfo<void> {
  const PaymentRoute({List<_i12.PageRouteInfo>? children})
    : super(PaymentRoute.name, initialChildren: children);

  static const String name = 'PaymentRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.PaymentPage();
    },
  );
}

/// generated route for
/// [_i10.RegistrationPage]
class RegistrationRoute extends _i12.PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({
    _i13.Key? key,
    required _i13.VoidCallback showLoginPage,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         RegistrationRoute.name,
         args: RegistrationRouteArgs(key: key, showLoginPage: showLoginPage),
         initialChildren: children,
       );

  static const String name = 'RegistrationRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegistrationRouteArgs>();
      return _i10.RegistrationPage(
        key: args.key,
        showLoginPage: args.showLoginPage,
      );
    },
  );
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({this.key, required this.showLoginPage});

  final _i13.Key? key;

  final _i13.VoidCallback showLoginPage;

  @override
  String toString() {
    return 'RegistrationRouteArgs{key: $key, showLoginPage: $showLoginPage}';
  }
}

/// generated route for
/// [_i11.SplashScreen]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.SplashScreen();
    },
  );
}
