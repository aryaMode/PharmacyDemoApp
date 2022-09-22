import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  final Color primaryColor = kPrimaryColor;
  final Color secondaryColor = kSecondaryColor;
  @override
  Widget build(BuildContext context) {
    
    List<DashboardTile> dashboardTiles = [DashboardTile(
                              title: "Tile 1",
                              onPressed: () {},
                            ),DashboardTile(
                              title: "Tile 2",
                              onPressed: () {},
                            ),DashboardTile(
                              title: "Tile 3",
                              onPressed: () {},
                            ),DashboardTile(
                              title: "Tile 4",
                              onPressed: () {},
                            ),DashboardTile(
                              title: "Tile 5",
                              onPressed: () {},
                            )];
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    Flexible(
                      child: GridView.count(crossAxisCount: 2, childAspectRatio:),
                    ),
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: DashboardTile(
                    //           title: "Tile 1",
                    //           onPressed: () {},
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: DashboardTile(
                    //           title: "Tile 2",
                    //           onPressed: () {},
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: DashboardTile(
                    //           title: "Tile 3",
                    //           onPressed: () {},
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: DashboardTile(
                    //           title: "Tile 4",
                    //           onPressed: () {},
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: DashboardTile(
                    //           title: "Tile 5",
                    //           onPressed: () {},
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatefulWidget {
  final String title;
  final void Function()? onPressed;

  DashboardTile({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<DashboardTile> createState() => _DashboardTileState();
}

class _DashboardTileState extends State<DashboardTile> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (isHovering) {
        setState(() {
          hovering = isHovering;
        });
      },
      hoverColor: Colors.transparent,
      splashColor: Colors.black.withOpacity(0.2),
      highlightColor: Colors.transparent,
      child: Container(
        height: 150.0,
        width: 200,
        margin: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: hovering == false ? Colors.transparent : Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
