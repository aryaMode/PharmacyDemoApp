import 'dart:developer';
import 'dart:io';

import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/models/tab_titles.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/dashboard_tile.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

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
      InkWell(
          onTap: () async {
            Directory? stringData =
                (await getApplicationDocumentsDirectory()).;
            print("");
          },
          child: Text("")),
    ];
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text(
          kCompanyName,
          style: kAppBarTextStyle,
        ),
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () async {
            await Locations.updateLocationsFromFirebase();
            await TabTitles.updateTabTitlesFromFirebase();
            await listExample();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.update,
                size: 30,
                color: Colors.black,
              ),
            ),
          )
        ],
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
