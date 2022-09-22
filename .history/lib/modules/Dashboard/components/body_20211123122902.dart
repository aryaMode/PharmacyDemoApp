import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final List<Widget> dashboardTiles;
  const Body({
    Key? key,
    required this.dashboardTiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Flexible(
                  child: GridView.(
                    itemCount: dashboardTiles.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.8),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return dashboardTiles[index];
                    },
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
