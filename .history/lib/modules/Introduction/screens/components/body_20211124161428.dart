import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_bar.dart';
import 'package:demo_catalog_app/widgets/button.dart';
import 'package:demo_catalog_app/widgets/elevated_icon_button.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool editableMode = false;
  List<ImageWidget> images = [
    ImageWidget(path: kTestImage),
    ImageWidget(path: kTestImage),
    ImageWidget(path: kTestImage),
  ];
  int currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 12,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  //? to be replaced by scrollable images
                  margin: EdgeInsets.only(bottom: 40),
                  child: ScrollableImages(
                    currentPageIndex: currentImageIndex,
                    editable: editableMode,
                    onAdd: () {},
                    onDelete: () {},
                    onPageChange: (val) {
                      setState(() {
                        currentImageIndex = val;
                      });
                    },
                    images: images,
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 30,
                  child: ElevatedIconButton(
                    icon: Icons.edit_rounded,
                    active: editableMode,
                    onPressed: () {
                      setState(() {
                        editableMode = !editableMode;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: BottomNavBar(
              margin: EdgeInsets.only(top: 6),
              widgets: currentImageIndex != images.length - 1
                  ? [
                      Button(
                        tileText: "Skip",
                        onPress: () {
                          context.router.replace(DashboardRoute());
                        },
                      ),
                    ]
                  : [
                      Button(
                        color: kPrimaryColor,
                        tileText: "Start",
                        onPress: () {
                          context.router.replace(DashboardRoute());
                        },
                      ),
                    ],
            ),
          )
        ],
      ),
    );
  }
}
