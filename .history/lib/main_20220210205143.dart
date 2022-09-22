import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/modules/Auth/auth_gate.dart';
import 'package:demo_catalog_app/modules/Auth/signin.dart';
import 'package:demo_catalog_app/modules/Auth/signup.dart';
import 'package:demo_catalog_app/modules/SplashScreen/screens/splash_screen.dart';
import 'package:demo_catalog_app/test/test_widget.dart';
import 'package:demo_catalog_app/utils/ui/setOrientation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes/routes.gr.dart' as router;
import 'config/themes/themes.dart';
import 'firebase_options.dart';

//Todo: Make sure 2 admins do not operate simultaneously.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    FirebaseDatabase database = FirebaseDatabase.instance;
    database.setPersistenceCacheSizeBytes(100000000);
    database.setPersistenceEnabled(true);
  }

  runApp(
    ProviderScope(
      child: DemoCatalogApp,
      // child: MaterialApp(home: TestWidget()),
    ),
  );
}

class DemoCatalogApp extends StatelessWidget {
  final _router = router.Router();
  @override
  Widget build(BuildContext context) {
    setOrientationLandscape();
    return MaterialApp.router(
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
      theme: primaryTheme.copyWith(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: kCompanyName,
    );
  }
}
