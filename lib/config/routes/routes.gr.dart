// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../modules/Auth/register.dart' as _i2;
import '../../modules/Auth/signin.dart' as _i1;
import '../../modules/Dashboard/dashboard.dart' as _i5;
import '../../modules/Introduction/introduction_page.dart' as _i4;
import '../../modules/Product/product_screen.dart' as _i6;
import '../../modules/SplashScreen/screens/splash_screen.dart' as _i3;
import '../../modules/Tabs/tab_screen.dart' as _i7;

class Router extends _i8.RootStackRouter {
  Router([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SignInRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SignIn());
    },
    RegisterRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.Register());
    },
    SplashScreenRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.SplashScreen());
    },
    IntroductionPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.IntroductionPage());
    },
    DashboardRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.Dashboard());
    },
    ProductScreenRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ProductScreen());
    },
    TabScreenRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.TabScreen());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i8.RouteConfig(RegisterRoute.name, path: '/Register'),
        _i8.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i8.RouteConfig(IntroductionPageRoute.name, path: '/introduction-page'),
        _i8.RouteConfig(DashboardRoute.name, path: '/Dashboard'),
        _i8.RouteConfig(ProductScreenRoute.name, path: '/product-screen'),
        _i8.RouteConfig(TabScreenRoute.name, path: '/tab-screen')
      ];
}

/// generated route for
/// [_i1.SignIn]
class SignInRoute extends _i8.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i2.Register]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: '/Register');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.SplashScreen]
class SplashScreenRoute extends _i8.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i4.IntroductionPage]
class IntroductionPageRoute extends _i8.PageRouteInfo<void> {
  const IntroductionPageRoute()
      : super(IntroductionPageRoute.name, path: '/introduction-page');

  static const String name = 'IntroductionPageRoute';
}

/// generated route for
/// [_i5.Dashboard]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: '/Dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i6.ProductScreen]
class ProductScreenRoute extends _i8.PageRouteInfo<void> {
  const ProductScreenRoute()
      : super(ProductScreenRoute.name, path: '/product-screen');

  static const String name = 'ProductScreenRoute';
}

/// generated route for
/// [_i7.TabScreen]
class TabScreenRoute extends _i8.PageRouteInfo<void> {
  const TabScreenRoute() : super(TabScreenRoute.name, path: '/tab-screen');

  static const String name = 'TabScreenRoute';
}
