import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/modules/Auth/signin.dart';
import 'package:demo_catalog_app/modules/Auth/signup.dart';
import 'package:demo_catalog_app/modules/Dashboard/dashboard.dart';
import 'package:demo_catalog_app/modules/Introduction/screens/components/introduction_page.dart';
import 'package:demo_catalog_app/modules/Product/product_screen.dart';
import 'package:demo_catalog_app/modules/SplashScreen/screens/splash_screen.dart';
import 'package:demo_catalog_app/modules/Tabs/tab_screen.dart';
import 'package:flutter/foundation.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SignIn, initial: kIsWeb),
    AutoRoute(page: SignUp),
    AutoRoute(page: SplashScreen),
    AutoRoute(page: IntroductionPage),
    AutoRoute(page: Dashboard),
    AutoRoute(page: ProductScreen),
    AutoRoute(page: TabScreen)
  ],
)
class $Router {}

// flutter packages pub run build_runner watch
// flutter packages pub run build_runner watch --delete-conflicting-outputs