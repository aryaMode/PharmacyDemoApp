// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../modules/Dashboard/dashboard.dart' as _i3;
import '../../modules/Introduction/screens/components/introduction_page.dart'
    as _i2;
import '../../modules/Product/product_screen.dart' as _i4;
import '../../modules/SplashScreen/screens/splash_screen.dart' as _i1;
import '../../modules/Tabs/tab_screen.dart' as _i5;

class Router extends _i6.RootStackRouter {
  Router([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreen());
    },
    IntroductionPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.IntroductionPage());
    },
    DashboardRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.Dashboard());
    },
    ProductScreenRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.ProductScreen());
    },
    TabRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.TabScreen());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i6.RouteConfig(IntroductionPageRoute.name, path: '/introduction-page'),
        _i6.RouteConfig(DashboardRoute.name, path: '/Dashboard'),
        _i6.RouteConfig(ProductScreenRoute.name, path: '/product-screen'),
        _i6.RouteConfig(TabRoute.name, path: '/Tab')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i6.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.IntroductionPage]
class IntroductionPageRoute extends _i6.PageRouteInfo<void> {
  const IntroductionPageRoute()
      : super(IntroductionPageRoute.name, path: '/introduction-page');

  static const String name = 'IntroductionPageRoute';
}

/// generated route for
/// [_i3.Dashboard]
class DashboardRoute extends _i6.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: '/Dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i4.ProductScreen]
class ProductScreenRoute extends _i6.PageRouteInfo<void> {
  const ProductScreenRoute()
      : super(ProductScreenRoute.name, path: '/product-screen');

  static const String name = 'ProductScreenRoute';
}

/// generated route for
/// [_i5.TabScreen]
class TabRoute extends _i6.PageRouteInfo<void> {
  const TabRoute() : super(TabRoute.name, path: '/Tab');

  static const String name = 'TabRoute';
}
