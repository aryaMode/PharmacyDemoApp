import 'package:demo_catalog_app/widgets/dashboard_tile.dart';
import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  
MyGridView;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        itemCount: 5,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        itemBuilder: (BuildContext context, int index) {
          return DashboardTile(title: "title", onPressed: () {});
        });
  }
}
