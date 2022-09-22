import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

import 'image_widget.dart';
import 'scrollable_images.dart';
import 'text_widget.dart';

class ProductsliderTile extends StatelessWidget {
  final bool editable;
  final List<ImageWidget>? productImages;
  final ImageWidget productLogo;
  final String productName;
  final String? productTagline;

  ProductsliderTile({
    this.editable = false,
    this.productImages,
    this.productLogo = const ImageWidget(),
    required this.productName,
    this.productTagline,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: kDefaultPadding*2),
              child: ScrollableImages(
                images: productImages,
                onAdd: () {},
                onDelete: () {},
                currentPageIndex: 0,
                editable: editable,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(right: kDefaultPadding*2, bottom: 10, left: kDefaultPadding*2),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: TextWidget(
                        text: productName,
                        textStyle: kProductNameTextStyle,
                        editable: editable,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: TextWidget(
                        text: productTagline ?? "",
                        textStyle:
                            TextStyle(fontSize: 18, fontFamily: 'PrinceFont'),
                        editable: editable,
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
                                  child: productLogo,
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