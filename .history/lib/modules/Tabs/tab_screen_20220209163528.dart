import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/constants/widgets.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tab_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/providers/tab_providers.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/custom_tabs.dart';
import 'package:demo_catalog_app/widgets/dialog_box.dart';
import 'package:demo_catalog_app/widgets/drop_down.dart';
import 'package:demo_catalog_app/widgets/edit_icon.dart';
import 'package:demo_catalog_app/widgets/filled_outline_button.dart';
import 'package:demo_catalog_app/widgets/folder.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:demo_catalog_app/widgets/rounded_icon.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/material.dart' hide Tab, TabController;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  @override
  Widget build(BuildContext context) {
    final editable = ref.watch(editableProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tabs",
          style: kAppBarTextStyle,
        ),
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        actions: [
          editable
              ? Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  height: getScreenHeight(context) * 0.2,
                  width: getScreenWidth(context) * 0.3,
                  child: DropDown(
                    padding: EdgeInsets.symmetric(horizontal: kDe),
                    items: Locations.locations,
                    value:
                        Locations.locations[ref.watch(locationIndexProvider)],
                    onChanged: (changedValue) {
                      ref.read(locationIndexProvider.state).state =
                          (Locations.locations.indexOf(changedValue!));
                    },
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: 30,
          ),
          EditIcon(
            padding: kDefaultPadding / 2,
          ),
        ],
      ),
      body: SafeArea(
        child: TabScreenBuilder(),
      ),
    );
  }
}

class TabScreenBuilder extends ConsumerStatefulWidget {
  const TabScreenBuilder({Key? key}) : super(key: key);

  @override
  ConsumerState<TabScreenBuilder> createState() => _TabScreenBuilderState();
}

class _TabScreenBuilderState extends ConsumerState<TabScreenBuilder> {
  late List<Widget> tabs;
  late List<Widget> folders;
  IconData dustbinIcon = Icons.delete_outline_rounded;
  late DragTarget bottomDustbin;
  void _initialization(List tabsData, BuildContext context, bool editable) {
    tabs = tabsData.map((tab) {
      return Draggable(
        childWhenDragging: SizedBox.shrink(),
        maxSimultaneousDrags: editable ? 1 : 0,
        data: tab.name,
        feedback: Opacity(
          opacity: 0.5,
          child: Container(
            width: ((getScreenWidth(context) / 12) * (6 / 4)),
            height: ((getScreenHeight(context) / 12) * (4 / 6)),
            child: FillOutlineButton(
              text: tab.name,
              borderColor: Colors.black12,
            ),
          ),
        ),
        child: FillOutlineButton(
          press: () {
            ref.read(tabIndexProvider.state).state = tabsData.indexOf(tab);
          },
          text: tab.name,
          onFieldSubmitted: (changedText) {
            TabController(index: tabsData.indexOf(tab), reader: ref.read)
                .rename(changedText);
          },
        ),
      );
    }).toList();
    folders = [
      for (int i = 0; i < 4; i++)
        Draggable(
          childWhenDragging: SizedBox.shrink(),
          maxSimultaneousDrags: editable ? 1 : 0,
          data: "Folder ${i + 1}",
          feedback: Opacity(
            opacity: 0.5,
            child: Container(
              height: getScreenHeight(context) / 6,
              width: getScreenWidth(context) / 6,
              child: Folder(
                text: "Folder ${i + 1}",
              ),
            ),
          ),
          child: Folder(
            text: "Folder ${i + 1}",
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => DialogBox(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    width: getScreenWidth(context) * 0.75,
                    height: getScreenHeight(context) * 0.75,
                    child: ScrollableImages(
                      //TODO:
                      // onAdd: () {},
                      // onDelete: () {},
                      images: [
                        Img(assetPath: kSplashScreenImage),
                        Img(assetPath: kTestImage)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
    ];
    bottomDustbin = DragTarget(
      builder: (BuildContext context, List<Object?> candidateData,
              List<dynamic> rejectedData) =>
          RoundedIcon(
        iconData: dustbinIcon,
        backgroundColor: kSecondaryColor,
        iconColor: kPrimaryColor,
        size: 55,
      ),
      onWillAccept: (data) {
        setState(() {
          dustbinIcon = Icons.delete_forever;
        });
        return true;
      },
      onLeave: (data) {
        setState(() {
          dustbinIcon = Icons.delete_outline_rounded;
        });
      },
      onAccept: (data) {
        setState(() {
          dustbinIcon = Icons.delete_outline_rounded;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncTabs = ref.watch(tabsStreamProvider);
    final editable = ref.watch(editableProvider);

    return asyncTabs.when(
      data: (tabsData) {
        tabsData.sort((a, b) => (a.index.compareTo(b.index)));
        Future.delayed(
          Duration.zero,
          () {
            ref.read(tabsProvider.state).state = tabsData;
          },
        );
        _initialization(tabsData, context, editable);
        return Stack(
          children: [
            Column(
              children: [
                CustomTabs(
                  onReorder: (oldIndex, newIndex) {},
                  filledOutlineButtonList: tabs,
                  footer: editable
                      ? [
                          buildAddButton(
                            onAddPress: () {
                              int newTabs = tabsData
                                  .where(
                                      (tab) => tab.name.startsWith("New tab"))
                                  .length;
                              TabsController(reader: ref.read).add(
                                  index: tabsData.length,
                                  name:
                                      "New tab ${newTabs == 0 ? "" : newTabs}");
                            },
                          )
                        ]
                      : [],
                ),
                Flexible(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.all(kDefaultPadding * 1.5),
                    child: ReorderableLayout(
                      childAspectRatio: getAspectRatio(context, aspectRatio: 1),
                      crossAxisCount: 3,
                      onReorder: (oldIndex, newIndex) {
                        final element = folders.removeAt(oldIndex);
                        folders.insert(newIndex, element);
                      },
                      children: folders,
                      reorderable: editable,
                      footer: [
                        Folder(
                          text: "+",
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            editable
                ? Positioned(
                    width: getScreenWidth(context),
                    bottom: kBottomBarHeight / 2,
                    child: bottomDustbin,
                  )
                : SizedBox.shrink(),
          ],
        );
      },
      error: (e, st) => Text("Error : $e"),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
