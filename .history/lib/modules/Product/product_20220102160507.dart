import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/constants/widgets.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/widgets/add_remove_icon_row.dart';
import 'package:demo_catalog_app/widgets/bottom_nav_button.dart';
import 'package:demo_catalog_app/widgets/custom_tabs.dart';
import 'package:demo_catalog_app/widgets/dialog_box.dart';
import 'package:demo_catalog_app/widgets/edit_icon.dart';
import 'package:demo_catalog_app/widgets/elevated_icon_button.dart';
import 'package:demo_catalog_app/widgets/filled_outline_button.dart';
import 'package:demo_catalog_app/widgets/folder.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:demo_catalog_app/widgets/search_field.dart';
import 'package:demo_catalog_app/widgets/text_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool editable = false;
  int currentPageIndex = 0;
  final PageController pageController = new PageController(initialPage: 0);
  List<String> text = [for (int i = 0; i < 40; i++) "Products ${i + 1}"];

  Widget allButton = FillOutlineButton(
    text: "All",
    backgroundColor: kSecondaryColor,
    textColor: Colors.white,
    press: () {},
  );

  @override
  Widget build(BuildContext context) {
    List<ProductsliderTile> products = [
      for (int i = 0; i < 40; i++)
        ProductsliderTile(
          productName: text[i],
          editable: editable,
        ),
    ];
    List<Widget> productTabs = [
      for (int i = 0; i < 4; i++)
        FillOutlineButton(
          editable: editable,
          press: () {},
          text: text[i],
          onFieldSubmitted: (changedText) {},
        ),
    ];

    Row productBottomNavBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BottomNavButton(
          tileText: "Seasonal scheme",
          onPress: () {},
        ),
        BottomNavButton(
          tileText: "Price list",
          onPress: () {
            showDialog(
                context: context,
                builder: (context) => DialogBox(
                      child: Container(
                        width: getScreenWidth(context) * 0.5,
                        height: getScreenHeight(context) * 0.5,
                        margin: EdgeInsets.all(kDefaultPadding / 4),
                        child: ScrollableImages(
                          onAdd: () {},
                          onDelete: () {},
                          editable: editable,
                          currentPageIndex: 0,
                          images: [
                            ImageWidget(path: kSplashScreenImage),
                            ImageWidget(path: kTestImage)
                          ],
                        ),
                      ),
                    ));
          },
        ),
        BottomNavButton(
          tileText: "offer",
          onPress: () {},
        ),
        ProductBottomButton(
          tileText: "other",
          onPress: () {},
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product",
          style: kAppBarTextStyle,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        leading: BackButton(color: Colors.black),
        actions: [
          Flexible(child: SearchField()),
          editable ? buildReorderIcon(context, products) : SizedBox.shrink(),
          EditIcon(
            padding: kDefaultPadding / 2,
            editable: editable,
            onPressed: () {
              setState(() {
                editable = !editable;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CustomTabs(
                  editable: editable,
                  onReorder: (oldIndex, newIndex) {},
                  filledOutlineButtonList: productTabs,
                  footer: editable
                      ? [
                          //! Change if awkward
                          allButton,
                          buildAddButton(
                            onAddPress: () {
                              int newTabs = text
                                  .where((s) => s.startsWith("New tab"))
                                  .length;
                              text.add(
                                  "New tab ${newTabs == 0 ? "" : newTabs}");
                              setState(
                                () {
                                  productTabs.add(
                                    FillOutlineButton(
                                      press: () {},
                                      text: text.last,
                                      onFieldSubmitted: (changedText) {
                                        setState(() {
                                          text.last = changedText;
                                        });
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ]
                      : [
                          allButton,
                        ],
                ),
                Flexible(
                  flex: 8,
                  child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: pageController,
                      itemCount: products.length,
                      onPageChanged: (val) {
                        currentPageIndex = val;
                      },
                      itemBuilder: (context, index) {
                        return products[index];
                      }),
                ),
              ],
            ),
            editable
                ? Positioned(
                    width: getScreenWidth(context),
                    top: getScreenHeight(context) * 0.12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 2),
                      child: AddRemoveIconRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        listLength: products.length,
                        onAdd: () {},
                        onDelete: () {},
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: getScreenHeight(context) / 10,
        child: productBottomNavBar,
      ),
    );
  }

  Container buildReorderIcon(
      BuildContext context, List<ProductsliderTile> products) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: ElevatedIconButton(
        active: editable,
        icon: Icons.compare_arrows_rounded,
        inheritedPadding: kDefaultPadding / 2,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => DialogBox(
                    child: ReorderableLayout(
                      crossAxisCount: 6,
                      padding: EdgeInsets.all(kDefaultPadding),
                      onReorder: (int oldIndex, int newIndex) {},
                      children: products
                          .map((e) => Folder(
                                text: e.productName,
                                backgroundImage: e.productImages?.first,
                              ))
                          .toList(),
                    ),
                  ));
        },
      ),
    );
  }
}

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
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: ScrollableImages(
                      images: productImages,
                      onAdd: () {},
                      onDelete: () {},
                      currentPageIndex: 0,
                      editable: editable,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(right: 30, bottom: 10, left: 30),
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


