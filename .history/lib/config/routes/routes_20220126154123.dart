import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/modules/Dashboard/dashboard.dart';
import 'package:demo_catalog_app/modules/Introduction/screens/components/introduction_page.dart';
import 'package:demo_catalog_app/modules/Product/product_screen.dart';
import 'package:demo_catalog_app/modules/SplashScreen/screens/splash_screen.dart';
import 'package:demo_catalog_app/modules/Tabs/tabs.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: IntroductionPage),
    AutoRoute(page: Dashboard),
    // AutoRoute(page: ProductScreen),
    AutoRoute(page: Tab)
  ],
)
class $Router {}

// flutter packages pub run build_runner watch
// flutter packages pub run build_runner watch --delete-conflicting-outputs