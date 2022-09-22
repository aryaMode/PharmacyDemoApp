import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/decorations.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () async {
        if (!kIsWeb) getSharedPrefValues();
        context.router
            .replace(!kIsWeb ? IntroductionPageRoute() : SignInRoute());
      },
    );
  }

  Future<void> getSharedPrefValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? admin = prefs.getBool("admin")?? null;
    String? location = prefs.getString("location")?? null;
    String? uid = prefs.getString("uid") ?? null;
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kSplashScreenDecoration,
      child: ImageWidget(image: Img(assetPath: kSplashScreenImage)),
    );
  }
}
