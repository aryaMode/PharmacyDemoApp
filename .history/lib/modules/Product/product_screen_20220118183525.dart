import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/constants/widgets.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/providers/product_providers.dart';
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
import 'package:demo_catalog_app/modules/Product/widgets/product_slider_tile.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:demo_catalog_app/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/product.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  bool editable = false;
  int currentPageIndex = 0;
  late List<Group> groups;
  late List<Product> listedProducts;
  late List<Widget> productTabs;
  late List<ProductsliderTile> productSliderTiles;
  late Widget allButton;
  final PageController pageController = new PageController(initialPage: 0);

  _initialization() {
    listedProducts = (groups.expand((group) => group.products)).toList();
    allButton = FillOutlineButton(
      text: "All",
      backgroundColor: kSecondaryColor,
      textColor: Colors.white,
      press: () {
        listedProducts = (groups.expand((group) => group.products)).toList();
      },
    );
    productTabs = [
      for (int i = 0; i < groups.length; i++)
        FillOutlineButton(
          editable: editable,
          press: () {
            listedProducts = groups[i].products;
          },
          text: groups[i].name,
          onFieldSubmitted: (changedText) {},
        ),
    ];

    productSliderTiles = [
      for (int i = 0; i < listedProducts.length; i++)
        ProductsliderTile(
          product: listedProducts[i],
          editable: editable,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final futureGroups = ref.watch(groupsProvider);
    Row productBottomNavBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BottomNavButton(
          tileText: "Seasonal\nScheme",
          onPress: () {},
        ),
        BottomNavButton(
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
                          editable: editable,
                          currentPageIndex: 0,
                          images: [
                            ImageWidget(image: Img(path: kSplashScreenImage))
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
        BottomNavButton(
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
          editable
              ? buildReorderIcon(context, listedProducts)
              : SizedBox.shrink(),
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
        child: futureGroups.when(
            data: (groups) {
              _initialization();
              return Stack(
                children: [
                  Column(
                    children: [
                      CustomTabs(
                        editable: editable,
                        onReorder: (oldIndex, newIndex) {},
                        filledOutlineButtonList: productTabs,
                        footer: editable
                            ? [
                                //? Change if it's awkward
                                allButton,
                                buildAddButton(
                                  onAddPress: () {
                                    int newTabs = groups
                                        .where((group) =>
                                            group.name.startsWith("New tab"))
                                        .length;
                                    groups.add(Group(
                                        name:
                                            "New tab ${newTabs == 0 ? "" : newTabs}",
                                        products: [Product.emptyProduct()]));
                                    setState(
                                      () {
                                        productTabs.add(
                                          FillOutlineButton(
                                            press: () {},
                                            text: groups.last.name,
                                            onFieldSubmitted: (changedText) {
                                              setState(() {
                                                groups.last.name = changedText;
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
                            itemCount: listedProducts.length,
                            onPageChanged: (val) {
                              currentPageIndex = val;
                            },
                            itemBuilder: (context, index) {
                              return productSliderTiles[index];
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
                              listLength: listedProducts.length,
                              onAdd: () {},
                              onDelete: () {},
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              );
            },
            error: (e, st) => Text('Error: $e'),
            loading: () => CircularProgressIndicator()),
      ),
      bottomNavigationBar: Container(
        height: getScreenHeight(context) / 10,
        child: productBottomNavBar,
      ),
    );
  }

  Container buildReorderIcon(BuildContext context, List<Product> products) {
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
                          .map((product) => Folder(
                                text: product.name,
                                backgroundImage: product.images
                                    .map((image) => image.toWidget())
                                    .first,
                              ))
                          .toList(),
                    ),
                  ));
        },
      ),
    );
  }
}
