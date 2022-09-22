import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/list_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_bar.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_button.dart';
import 'package:demo_catalog_app/widgets/button.dart';
import 'package:demo_catalog_app/widgets/elevated_icon_button.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroductionPage extends ConsumerStatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends ConsumerState<IntroductionPage> {
  List<ImageWidget> images = [
    ImageWidget(image: Img(path: kTestImage)),
    ImageWidget(image: Img(path: kTestImage)),
    ImageWidget(image: Img(path: kTestImage)),
  ];
  int currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final editable = ref.watch(editableProvider);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ScrollableImages(
            currentPageIndex: currentImageIndex,
            editable: editable,
            onAdd: () {
              setState(() {
                images.insert(currentImageIndex + 1, ImageWidget(image: Img()));
                ++currentImageIndex;
              });
            },
            onDelete: () {
              setState(() {
                images.removeAt(currentImageIndex);
                if (isLast(currentImageIndex, images.length + 1)) {
                  currentImageIndex--;
                }
              });
            },
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
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: ElevatedIconButton(
                inheritedPadding: kDefaultPadding / 2,
                icon: Icons.edit_rounded,
                active: editable,
                onPressed: () {
                  ref.read(pro)
                },
              ),
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
