import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
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
                ?.copyWith(color: Colors.white)),
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
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

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.dashboardTiles,
  }) : super(key: key);

  final List<DashboardTile> dashboardTiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 12,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Flexible(
                  child: GridView.count(
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    children: dashboardTiles,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

