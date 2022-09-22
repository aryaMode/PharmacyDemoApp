import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Product/controllers/product_controller.dart';
import 'package:demo_catalog_app/modules/Product/providers/product_providers.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_button.dart';
import 'package:demo_catalog_app/widgets/dialog_box.dart';
import 'package:demo_catalog_app/widgets/drop_down.dart';
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
          onPress: () {
            ref.read(tabTitleIndexProvider.state).state = 0;
            context.router.navigate(TabScreenRoute());
          },
        ),
        Visibility(
          visible: ref.watch(editableProvider) ||
              ref
                      .watch(productProvider)
                      .priceList
                      .values.firstWhere((element) => false)()
                      .image
                      ?.url !=
                  null,
          child: BottomNavButton(
            padding: EdgeInsets.all(15),
            tileText: "Price list",
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => Consumer(
                  builder: (context, ref, _) => DialogBox(
                    child: Container(
                      width: getScreenWidth(context) * 0.75,
                      height: getScreenHeight(context) * 0.75,
                      margin: EdgeInsets.all(kDefaultPadding / 4),
                      child: Stack(
                        children: [
                          ref.watch(editableProvider)
                              ? ImagePicker(
                                  image: ref
                                      .watch(productProvider)
                                      .priceList
                                      .values
                                      .firstWhere((locationImage) =>
                                          locationImage.location ==
                                          Locations.locations[
                                              ref.watch(locationIndexProvider)])
                                      .image,
                                  onTap: (pickedFile) async {
                                    ProductController(id: product.id)
                                        .setPriceListImage(
                                            pickedFile, ref.read);
                                  },
                                )
                              : ImageWidget(
                                  image: ref
                                      .watch(productProvider)
                                      .priceList
                                      .values
                                      .firstWhere((locationImage) =>
                                          locationImage.location ==
                                          Locations.locations[
                                              ref.watch(locationIndexProvider)])
                                      .image),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(kDefaultPadding),
                              height: getScreenHeight(context) * 0.1,
                              width: getScreenWidth(context) * 0.3,
                              child: DropDown(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding * 2),
                                items: Locations.locations,
                                value: Locations.locations[
                                    ref.watch(locationIndexProvider)],
                                onChanged: (changedValue) {
                                  ref.read(locationIndexProvider.state).state =
                                      (Locations.locations
                                          .indexOf(changedValue!));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: ref.watch(editableProvider) ||
              ref.watch(productProvider).offer?.url != null,
          child: BottomNavButton(
            tileText: "offer",
            padding: EdgeInsets.all(15),
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => Consumer(
                  builder: (context, ref, _) {
                    final product = ref.watch(productProvider);
                    return DialogBox(
                      child: Container(
                        child: ref.watch(editableProvider)
                            ? ImagePicker(
                                image: product.offer,
                                onTap: (pickedFile) async {
                                  ProductController(id: product.id)
                                      .setOffer(pickedFile);
                                },
                              )
                            : ImageWidget(image: product.offer),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: ref.watch(editableProvider) ||
              ref.watch(productProvider).other?.url != null,
          child: BottomNavButton(
            tileText: "other",
            padding: EdgeInsets.all(15),
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => Consumer(
                  builder: (context, ref, _) {
                    final product = ref.watch(productProvider);
                    return DialogBox(
                      child: Container(
                        child: ref.watch(editableProvider)
                            ? ImagePicker(
                                image: product.other,
                                onTap: (pickedFile) async {
                                  ProductController(id: product.id)
                                      .setOther(pickedFile);
                                },
                              )
                            : ImageWidget(image: product.other),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        )
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
                      onAdd: (index) async {
                        await ProductController(id: product.id)
                            .addImage(index + 1);
                      },
                      onDelete: (index) async {
                        await ProductController(id: product.id)
                            .deleteImage(index);
                      },
                      onEdit: (index, newImageFile) async {
                        await ProductController(id: product.id)
                            .editImage(index, newImageFile);
                      },
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
                              style: kProductNameTextStyle,
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
                              style: TextStyle(
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
                                                onTap: (pickedFile) async {
                                                  ProductController(
                                                          id: product.id)
                                                      .setLogo(pickedFile);
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
