import 'package:demo_catalog_app/widgets/dashboard_tile.dart';
import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  final List<Widget> dashboardTiles;
  MyGridView({required this.dashboardTiles});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        itemCount: dashboardTiles.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        itemBuilder: (BuildContext context, int index) {
          return dashboardTiles
        });
  }
}
