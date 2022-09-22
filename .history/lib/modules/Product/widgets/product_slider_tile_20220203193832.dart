import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Product/controllers/product_controller.dart';
import 'package:demo_catalog_app/modules/Product/providers/product_providers.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_button.dart';
import 'package:demo_catalog_app/widgets/dialog_box.dart';
import 'package:demo_catalog_app/widgets/image_picker.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/scrollable_images.dart';
import '../../../widgets/text_widget.dart';

class ProductsliderTile extends ConsumerWidget {
  const ProductsliderTile();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider);
    Row productBottomNavBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BottomNavButton(
          tileText: "Seasonal Scheme",
          padding: EdgeInsets.all(15),
          onPress: () {},
        ),
        BottomNavButton(
          padding: EdgeInsets.all(15),
          tileText: "Price list",
          onPress: () {
            showDialog(
                context: context,
                builder: (context) => DialogBox(
                      child: Container(
                        width: getScreenWidth(context) * 0.75,
                        height: getScreenHeight(context) * 0.75,
                        margin: EdgeInsets.all(kDefaultPadding / 4),
                        child: ScrollableImages(
                          onAdd: () {},
                          onDelete: () {},
                          currentPageIndex: 0,
                          images: [
                            Img(
                              path: kSplashScreenImage,
                            )
                          ],
                        ),
                      ),
                    ));
          },
        ),
        BottomNavButton(
          tileText: "offer",
          padding: EdgeInsets.all(15),
          onPress: () {},
        ),
        BottomNavButton(
          tileText: "other",
          padding: EdgeInsets.all(15),
          onPress: () {},
        ),
      ],
    );
    return Column(
      children: [
        Flexible(
          flex: 10,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: kDefaultPadding * 2),
                    child: ScrollableImages(
                      images: product.images.values.toList(),
                      onAdd: () {},
                      onDelete: () {},
                      currentPageIndex: 0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(
                        right: kDefaultPadding * 2,
                        bottom: 10,
                        left: kDefaultPadding * 2),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: TextWidget(
                              text: product.name,
                              hintText: "Product name",
                              textStyle: kProductNameTextStyle,
                              onSubmitted: (changedText) =>
                                  ProductController(id: product.id)
                                      .rename(changedText),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: TextWidget(
                              hintText: "Tagline",
                              text: product.tagline ?? "",
                              textStyle: TextStyle(
                                  fontSize: 18, fontFamily: 'PrinceFont'),
                              onSubmitted: (changedText) =>
                                  ProductController(id: product.id)
                                      .setTagline(changedText),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 150,
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: ref.watch(editableProvider)
                                            ? ImagePicker(
                                                image: product.logo,
                                                onTap: (url) async {
                                                  if (product.logo != null &&
                                                      product.logo!.url !=
                                                          null) {
                                                    await removeWebImage(
                                                        product.logo!.url!);
                                                  }
                                                  Product
                                                  //setState(() {
                                                  //widget.image = Img(url: url);
                                                  //});
                                                },
                                              )
                                            : ImageWidget(image: product.logo),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            // height: getScreenHeight(context) / 10,
            child: productBottomNavBar,
          ),
        ),
      ],
    );
  }
}
