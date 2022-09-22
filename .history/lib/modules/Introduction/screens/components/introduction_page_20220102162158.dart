import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/utils/helper/list_helper.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_bar.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_button.dart';
import 'package:demo_catalog_app/widgets/button.dart';
import 'package:demo_catalog_app/widgets/elevated_icon_button.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          ScrollableImages(
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
          Positioned(
            top: kIntroductionPageEditSpacing,
            right: kIntroductionPageEditSpacing,
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
      bottomNavigationBar: BottomNavBar(
        widgets: !isLast(currentImageIndex, images.length)
            ? [
                BottomNavButton.copy(
                  tileText: "Skip",
                  onPress: () {
                    context.router.replace(DashboardRoute());
                  },
                ),
              ]
            : [
                BottomNavButton(
                  color: kSecondaryColor,
                  tileText: "Start",
                  style: kButtonTextStyle,
                  onPress: () {
                    context.router.replace(DashboardRoute());
                  },
                ),
              ],
      ),
    );
  }
}
