import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/decorations.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/models/tab_titles.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/providers/auth_providers.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
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
  bool toSignIn = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () async {
        await _getDataAndNavigate();
      },
    );
  }

  Future<void> _getDataAndNavigate() async {
    if (!kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? admin = prefs.getBool("admin") ?? null;
      String? location = prefs.getString("location") ?? null;
      String? uid = prefs.getString("uid") ?? null;
      List<String>? locations = prefs.getStringList("locations");
      List<String>? tabTitles = prefs.getStringList("tabTitles");
      toSignIn = admin == null ||
          location == null ||
          uid == null ||
          locations == null ||
          tabTitles == null;
      if (!toSignIn) {
        ref.read(userProvider.state).state =
            AuthUser(admin: admin!, location: location!, uid: uid!);
        Locations.locations = locations!;
        TabTitles.tabTitles = tabTitles!;
        ref.read(locationIndexProvider.state).state =
            Locations.locations.indexOf(location);
        await preCacheImageFiles();
      }
    } else {
      toSignIn = ref.read(userProvider) == null;
    }
    AutoRouter.of(context)
        .replace((toSignIn) ? SignInRoute() : IntroductionPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: Container(
        decoration: kSplashScreenDecoration,
        child: ImageWidget(image: Img(assetPath: kSplashScreenImage)),
      ),
    );
  }
}
