import 'dart:io';

import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:demo_catalog_app/modules/Auth/providers/auth_providers.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_button.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/dashboard_tile.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> dashboardTiles = [
      DashboardTile(
          title: "Seasonal Scheme",
          onPressed: () {
            ref.read(tabTitleIndexProvider.state).state = 0;
            context.router.navigate(TabScreenRoute());
          }),
      DashboardTile(
          title: "Price List",
          onPressed: () {
            ref.read(tabTitleIndexProvider.state).state = 1;
            context.router.navigate(TabScreenRoute());
          }),
      DashboardTile(
          title: "Product Offer",
          onPressed: () {
            ref.read(tabTitleIndexProvider.state).state = 2;
            context.router.navigate(TabScreenRoute());
          }),
      DashboardTile(
        title: "Product",
        onPressed: () {
          context.router.navigate(ProductScreenRoute());
        },
      ),
      DashboardTile(
          title: "Others",
          onPressed: () {
            ref.read(tabTitleIndexProvider.state).state = 3;
            context.router.navigate(TabScreenRoute());
          }),
    ];
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: Drawer(
        backgroundColor: kPrimaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: ),
              child: Text("Header"),
            ),
            Visibility(
              visible: ref.watch(userProvider)!.admin,
              child: ListTile(
                title: AuthButton(
                  text: "Register User",
                  onTap: () {
                    context.router.push(RegisterRoute());
                  },
                ),
              ),
            ),
            ListTile(
              title: AuthButton(
                text: "Logout",
                onTap: () async {
                  await AuthServices.auth.signOut();
                  if (!kIsWeb) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove("location");
                    await prefs.remove("admin");
                    await prefs.remove("uid");
                    await prefs.remove("locations");
                    await prefs.remove("tabTitles");
                    var appDir = (await getTemporaryDirectory()).path;
                    Directory(appDir).delete(recursive: true);
                  }
                  context.router.push(SignInRoute());
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          kCompanyName,
          style: kAppBarTextStyle,
        ),
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: buildDashboard(context, dashboardTiles),
            ),
          ],
        ),
      ),
    );
  }

  ReorderableLayout buildDashboard(
      BuildContext context, List<Widget> dashboardTiles) {
    return ReorderableLayout(
      padding: EdgeInsets.all(kDefaultPadding),
      crossAxisCount: 2,
      onReorder: (oldIndex, newIndex) {},
      childAspectRatio: getAspectRatio(context),
      reorderable: false,
      children: dashboardTiles,
    );
  }
}
