import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/list_helper.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_bar.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_button.dart';
import 'package:demo_catalog_app/widgets/edit_icon.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  late List<Img> images;
  int currentImageIndex = 0;
  _initialization
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ScrollableImages(
            //TODO:
            // onAdd: () {
            //   setState(() {
            //     images.insert(
            //       currentImageIndex + 1,
            //       Img(),
            //     );
            //     ++currentImageIndex;
            //   });
            // },
            // onDelete: () {
            //   setState(() {
            //     images.removeAt(currentImageIndex);
            //     if (isLast(currentImageIndex, images.length + 1)) {
            //       currentImageIndex--;
            //     }
            //   });
            // },
            images: images,
          ),
          Positioned(
            top: kIntroductionPageEditSpacing,
            right: kIntroductionPageEditSpacing,
            child: EditIcon(
              padding: kDefaultPadding / 2,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        widgets: !isLast(currentImageIndex, images.length)
            ? [
                BottomNavButton(
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
                  textStyle: kButtonTextStyle.copyWith(color: Colors.white),
                  onPress: () {
                    context.router.replace(DashboardRoute());
                  },
                ),
              ],
      ),
    );
  }
}
