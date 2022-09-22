import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Introduction/controlller/intro_controller.dart';
import 'package:demo_catalog_app/modules/Introduction/providers/intro_providers.dart';
import 'package:demo_catalog_app/utils/helper/list_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_bar.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_button.dart';
import 'package:demo_catalog_app/widgets/edit_icon.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroductionPage extends ConsumerStatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends ConsumerState<IntroductionPage> {
  final currentImageIndexProvider = StateProvider((ref) => 0);
  List<Img> images = [];
  @override
  Widget build(BuildContext context) {
    final asyncImages = ref.watch(introImagesStreamProvider);

    return Scaffold(
      body: asyncImages.when(
        data: (imagesData) {
          images = imagesData;
          WidgetsBinding.instance?.addPostFrameCallback(
            (_) {
              ref.read(introImagesProvider.state).state = images;
            },
          );
          return Stack(
            fit: StackFit.expand,
            children: [
              ScrollableImages(
                onAdd: (index) async {
                  await IntroImagesController().addImage(index + 1);
                  ref
                      .read(currentImageIndexProvider.state)
                      .update((state) => state++);
                },
                onDelete: (index) async {
                  await IntroImagesController().deleteImage(index);
                  ref
                      .read(currentImageIndexProvider.state)
                      .update((state) => state - (state != 0 ? 1 : 0));
                },
                onEdit: (index, newImageFile) async {
                  await IntroImagesController().editImage(index, newImageFile);
                },
                onPageChange: (index){
                  ref
                      .read(currentImageIndexProvider.state)
                      .state = index;
                },
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
          );
        },
        error: (e, st) => Text("Error : $e"),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        widgets: !isLast(ref.watch(currentImageIndexProvider),
                ref.watch(introImagesProvider).length)
            ? [
                BottomNavButton(
                  tileText: "Skip",
                  onPress: () {
                    AutoRouter.of(context).popAndPush(DashboardRoute());
                  },
                ),
              ]
            : [
                BottomNavButton(
                  color: kSecondaryColor,
                  tileText: "Start",
                  textStyle: kButtonTextStyle.copyWith(color: Colors.white),
                  onPress: () {
                    AutoRouter.of(context).popAndPush(DashboardRoute());
                  },
                ),
              ],
      ),
    );
  }
}
