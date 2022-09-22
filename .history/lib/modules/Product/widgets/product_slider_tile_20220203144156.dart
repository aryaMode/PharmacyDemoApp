import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/modules/Product/providers/product_providers.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
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
    return Container(
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
                        textStyle: kProductNameTextStyle,
                        onSubmitted: ,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: TextWidget(
                        text: product.tagline ?? "",
                        textStyle:
                            TextStyle(fontSize: 18, fontFamily: 'PrinceFont'),
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
                                      ? ImagePicker(image: product.logo)
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
    );
  }
}
