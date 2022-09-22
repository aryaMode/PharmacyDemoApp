import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/utils/ui/setOrientation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'config/routes/routes.gr.dart' as router;
import 'config/themes/themes.dart';
import 'firebase_options.dart';

//Todo: Make sure 2 admins do not operate simultaneously.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase database = FirebaseDatabase.instance;
  database.setPersistenceCacheSizeBytes(100000);
  database.setPersistenceEnabled(true);
  runApp(DemoCatalogApp());
}

class DemoCatalogApp extends StatelessWidget {
  final _router = router.Router();
  @override
  Widget build(BuildContext context) {
    setOrientationLandscape();

    return MaterialApp.router(
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
      theme: primaryTheme,
      debugShowCheckedModeBanner: false,
      title: kCompanyName,
    );
  }
}
