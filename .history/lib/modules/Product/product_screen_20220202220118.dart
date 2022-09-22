import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/constants/widgets.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/providers/product_providers.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
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
  @override
  Widget build(BuildContext context) {
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
          // editable
          //     ? buildReorderIcon(context, <Product>[]
          //         ref.watch(
          //           productsProvider(
          //             ref.watch(selectedTabsIndicesProvider),
          //           ),
          //         ),
          //         )
          //     :
          SizedBox.shrink(),
          EditIcon(
            padding: kDefaultPadding / 2,
          ),
        ],
      ),
      body: SafeArea(
        child: ProductScreenBuilder(),
      ),
      bottomNavigationBar: Container(
        height: getScreenHeight(context) / 10,
        child: productBottomNavBar,
      ),
    );
  }

  Container buildReorderIcon(BuildContext context, List<Product>? products) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: ElevatedIconButton(
        active: ref.watch(editableProvider),
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
                      children: products != null
                          ? products
                              .map((Product product) => Folder(
                                    editable: false,
                                    text: product.name,
                                    backgroundImage: ImageWidget(
                                        image: product.images.values.first),
                                  ))
                              .toList()
                          : [],
                    ),
                  ));
        },
      ),
    );
  }
}

class ProductScreenBuilder extends ConsumerStatefulWidget {
  const ProductScreenBuilder({Key? key}) : super(key: key);

  @override
  _ProductScreenBuilderState createState() => _ProductScreenBuilderState();
}

class _ProductScreenBuilderState extends ConsumerState<ProductScreenBuilder> {
  late List<Widget> groupTabs;
  late List<ProductsliderTile> productSliderTiles;
  late Widget allButton;

  _initialization(List<Group> groups) {
    allButton = FillOutlineButton(
      editable: false,
      text: "All",
      backgroundColor: kSecondaryColor,
      textColor: Colors.white,
      press: () {
        ref.read(selectedGroupsIndicesProvider.state).state = [
          for (int i = 0; i < groups.length; i++) i
        ];
      },
    );
    groupTabs = groups.map(
      (group) {
        return FillOutlineButton(
          press: () {
            ref.read(selectedGroupsIndicesProvider.state).state = [
              groups.indexOf(group)
            ];
          },
          text: group.name,
          onFieldSubmitted: (changedText) {},
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final asyncGroups = ref.watch(groupsStreamProvider);
    final editable = ref.watch(editableProvider);

    return asyncGroups.when(
      data: (groups) {
        print("DATA");
        groups.forEach(
          (group) => print(
            group.toMap(),
          ),
        );
        _initialization(groups);
        return Stack(
          children: [
            Column(
              children: [
                CustomTabs(
                  onReorder: (oldIndex, newIndex) {},
                  filledOutlineButtonList: groupTabs,
                  footer: editable
                      ? [
                          //? Change if it's awkward
                          allButton,
                          buildAddButton(
                            onAddPress: () {
                              // int? newTabs = groups
                              //     .where((group) =>
                              //         group.name.startsWith("New tab"))
                              //     .length;
                              // TODO:
                              // groups.add(
                              //   Group.emptyGroup(
                              //       name:
                              //           "New tab ${newTabs == 0 ? "" : newTabs}",
                              //       index: (groups.length - 1)),
                              // );
                              groupTabs.add(
                                FillOutlineButton(
                                  press: () {},
                                  text: groups.last.name,
                                  onFieldSubmitted: (changedText) {
                                    groups.last.name = changedText;
                                  },
                                ),
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
                  child: ProductPageView(editable: editable),
                ),
              ],
            ),
          ],
        );
      },
      error: (e, st) => Text("Error : $e"),
      loading: () {
        print("group loading");
        return CircularProgressIndicator();
      },
    );
  }
}

class ProductPageView extends ConsumerStatefulWidget {
  const ProductPageView({
    Key? key,
    required this.editable,
  }) : super(key: key);
  final bool editable;

  @override
  ConsumerState<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends ConsumerState<ProductPageView> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;
  late List<ProductsliderTile> productSliderTiles;

  void initialization(List<Product> selectedProducts) {
    productSliderTiles = [
      for (int i = 0; i < selectedProducts.length; i++)
        ProductsliderTile(
          productIndex: i,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final streamProducts = ref.watch(productsProvider.stream);
    return StreamBuilder(
      stream: streamProducts,
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        Widget child = SizedBox.shrink();
        List<Product>? selectedProducts = snapshot.data;
        if (!snapshot.hasError) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            child = const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            print("PRODUCT DATA");
            initialization(selectedProducts!);
            child = Stack(
              children: [
                PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: pageController,
                    itemCount: selectedProducts.length,
                    onPageChanged: (val) {
                      currentPageIndex = val;
                    },
                    itemBuilder: (context, index) {
                      return productSliderTiles[index];
                    }),
                widget.editable
                    ? Positioned(
                        width: getScreenWidth(context),
                        top: getScreenHeight(context) * 0.12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 2),
                          child: AddRemoveIconRow(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            listLength: selectedProducts.length,
                            onAdd: () {},
                            onDelete: () {},
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            );
          }
        } else {
          child = Text("Error ${snapshot.error}");
        }
        return child;
      },
    );
    // return asyncProducts.when(
    //   data: (selectedProducts) {
    //     print("PRODUCT DATA");
    //     initialization(selectedProducts);
    //     return Stack(
    //       children: [
    //         PageView.builder(
    //             scrollDirection: Axis.vertical,
    //             controller: pageController,
    //             itemCount: selectedProducts.length,
    //             onPageChanged: (val) {
    //               currentPageIndex = val;
    //             },
    //             itemBuilder: (context, index) {
    //               return productSliderTiles[index];
    //             }),
    //         widget.editable
    //             ? Positioned(
    //                 width: getScreenWidth(context),
    //                 top: getScreenHeight(context) * 0.12,
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: kDefaultPadding * 2),
    //                   child: AddRemoveIconRow(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     listLength: selectedProducts.length,
    //                     onAdd: () {},
    //                     onDelete: () {},
    //                   ),
    //                 ),
    //               )
    //             : SizedBox.shrink(),
    //       ],
    //     );
    //   },
    //   loading: () {
    //     print("products loading");
    //     return CircularProgressIndicator();
    //   },
    //   error: (e, st) => Text("Error : $e"),
    // );
  }
}
