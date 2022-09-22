import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/modules/Dashboard/components/body.dart';
import 'package:demo_catalog_app/widgets/dashboard_tile.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  final Color primaryColor = kPrimaryColor;
  final Color secondaryColor = kSecondaryColor;
  @override
  Widget build(BuildContext context) {
    List<DashboardTile> dashboardTiles = [
      DashboardTile(
        title: "Tile 1",
        onPressed: () {},
      ),
      DashboardTile(
        title: "Tile 2",
        onPressed: () {},
      ),
      DashboardTile(
        title: "Tile 3",
        onPressed: () {},
      ),
      DashboardTile(
        title: "Tile 4",
        onPressed: () {},
      ),
      DashboardTile(
        title: "Tile 5",
        onPressed: () {},
      ),
    ];
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(kCompanyName,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.black)),
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
        child: Body(dashboardTiles: dashboardTiles),
      ),
    );
  }
}
