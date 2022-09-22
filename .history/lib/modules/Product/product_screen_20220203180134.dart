import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/constants/widgets.dart';
import 'package:demo_catalog_app/modules/Product/controllers/group_controller.dart';
import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/providers/product_providers.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/add_remove_icon_row.dart';
import 'package:demo_catalog_app/widgets/custom_tabs.dart';
import 'package:demo_catalog_app/widgets/dialog_box.dart';
import 'package:demo_catalog_app/widgets/edit_icon.dart';
import 'package:demo_catalog_app/widgets/elevated_icon_button.dart';
import 'package:demo_catalog_app/widgets/filled_outline_button.dart';
import 'package:demo_catalog_app/widgets/folder.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/modules/Product/widgets/product_slider_tile.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
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
          // TODO: Flexible(child: SearchField()),
          ref.watch(editableProvider)
              ? Visibility(
                  visible: ref.watch(selectedGroupsIndicesProvider) != -1,
                  child: buildReorderIcon(
                    context,
                  ),
                )
              : SizedBox.shrink(),
          EditIcon(
            padding: kDefaultPadding / 2,
          ),
        ],
      ),
      body: SafeArea(
        child: ProductScreenBuilder(),
      ),
    );
  }

  Container buildReorderIcon(BuildContext context) {
          final products = ref.read(productsProvider);
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
                      onReorder: (int oldIndex, int newIndex) {
                        GroupController(
                                index: ref.read(selectedGroupsIndicesProvider))
                            .reorderProduct(oldIndex, newIndex);
                      },
                      children: products
                          .map((Product product) => Folder(
                                editable: false,
                                text: product.name,
                                backgroundImage: ImageWidget(
                                    image: product.images.values.first),
                              ))
                          .toList(),
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
        ref.refresh(pageIndexProvider);
        ref.read(selectedGroupsIndicesProvider.state).state = -1;
      },
    );
    groupTabs = groups.map(
      (group) {
        return FillOutlineButton(
          press: () {
            ref.refresh(pageIndexProvider);
            ref.read(selectedGroupsIndicesProvider.state).state =
                groups.indexOf(group);
          },
          text: group.name,
          onFieldSubmitted: (changedText) {
            GroupController(index: groups.indexOf(group)).rename(changedText);
          },
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
        groups.sort((a, b) => (a.index.compareTo(b.index)));
        Future.delayed(
          Duration.zero,
          () {
            ref.read(groupsProvider.state).state = groups;
          },
        );
        _initialization(groups);
        return Stack(
          children: [
            Column(
              children: [
                CustomTabs(
                  onReorder: (oldIndex, newIndex) {
                    GroupsController().reorder(oldIndex, newIndex);
                  },
                  filledOutlineButtonList: groupTabs,
                  footer: editable
                      ? [
                          //? Change if it's awkward
                          allButton,
                          buildAddButton(
                            onAddPress: () {
                              int? newTabs = groups
                                  .where((group) =>
                                      group.name.startsWith("New tab"))
                                  .length;
                              GroupsController().add(
                                index: groups.length,
                                name: "New tab ${newTabs == 0 ? "" : newTabs}",
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
      error: (e, st) => Text("Error : $e , $st"),
      loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
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

  @override
  Widget build(BuildContext context) {
    final selectedProducts = ref.watch(productsProvider);
    return Stack(
      children: [
        PageView.builder(
            scrollDirection: Axis.vertical,
            controller: pageController,
            itemCount: selectedProducts.length,
            onPageChanged: (val) {
              ref.read(pageIndexProvider.state).state = val;
            },
            itemBuilder: (context, index) {
              return const ProductsliderTile();
            }),
        widget.editable
            ? Positioned(
                width: getScreenWidth(context),
                top: getScreenHeight(context) * 0.12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 2),
                  child: Visibility(
                    visible: ref.watch(selectedGroupsIndicesProvider) != -1,
                    child: AddRemoveIconRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      listLength: selectedProducts.length,
                      onAdd: () async {
                        await GroupController(
                                index: ref.read(selectedGroupsIndicesProvider))
                            .addProduct(ref.read(pageIndexProvider) + 1);
                        final pageIndexState =
                            ref.read(pageIndexProvider.state);
                        pageIndexState.update((state) => state + 1);
                        pageController.animateToPage(
                          pageIndexState.state,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      onDelete: () async {
                        await GroupController(
                                index: ref.read(selectedGroupsIndicesProvider))
                            .deleteProduct(ref.read(pageIndexProvider));
                        final pageIndexState =
                            ref.read(pageIndexProvider.state);
                        pageIndexState
                            .update((state) => state != 0 ? state - 1 : state);

                        ref.read(selectedGroupsIndicesProvider.state).update(
                            (state) =>
                                (selectedProducts.length == 1 && state != 0)
                                    ? state - 1
                                    : state);

                        pageController.animateToPage(
                          pageIndexState.state,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
