import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/constants/widgets.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/custom_tabs.dart';
import 'package:demo_catalog_app/widgets/dialog_box.dart';
import 'package:demo_catalog_app/widgets/drop_down.dart';
import 'package:demo_catalog_app/widgets/edit_icon.dart';
import 'package:demo_catalog_app/widgets/elevated_icon_button.dart';
import 'package:demo_catalog_app/widgets/filled_outline_button.dart';
import 'package:demo_catalog_app/widgets/folder.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:demo_catalog_app/widgets/rounded_icon.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class Tab extends ConsumerStatefulWidget {
  const Tab({Key? key}) : super(key: key);

  @override
  _TabState createState() => _TabState();
}

List<String> text = [for (int i = 0; i < 4; i++) "Tab $i"];

class _TabState extends ConsumerState<Tab> {
  String dropDownValue = "Gujarat";
  IconData dustbinIcon = Icons.delete_outline_rounded;
  @override
  Widget build(BuildContext context) {
    final editable = ref.watch(editableProvider);
    List<Widget> tabs = [];
    tabs = [
      for (int i = 0; i < 4; i++)
        Draggable(
          childWhenDragging: SizedBox.shrink(),
          maxSimultaneousDrags: editable ? 1 : 0,
          data: "Tab ${i + 1}",
          feedback: Opacity(
            opacity: 0.5,
            child: Container(
              width: ((getScreenWidth(context) / 12) * (6 / 4)),
              height: ((getScreenHeight(context) / 12) * (4 / 6)),
              child: FillOutlineButton(
                text: text[i],
                borderColor: Colors.black12,
              ),
            ),
          ),
          child: FillOutlineButton(
            press: () {},
            editable: editable,
            text: text[i],
            onFieldSubmitted: (changedText) {
              setState(() {
                text[i] = changedText;
              });
            },
          ),
        )
    ];
    List<Widget> folders = [
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
            editable: editable,
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => DialogBox(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    width: getScreenWidth(context) * 0.75,
                    height: getScreenHeight(context) * 0.75,
                    child: ScrollableImages(
                      onAdd: () {},
                      onDelete: () {},
                      editable: editable,
                      currentPageIndex: 0,
                      images: [
                        ImageWidget(image: Img(path: kSplashScreenImage)),
                        ImageWidget(image: Img(path: kTestImage))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
    ];
    DragTarget bottomDustbin = DragTarget(
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
                    value: dropDownValue,
                    onChanged: (changedValue) {
                      setState(() {
                        dropDownValue = changedValue.toString();
                      });
                    },
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: 30,
          ),
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
                  onReorder: (oldIndex, newIndex) {},
                  editable: editable,
                  filledOutlineButtonList: tabs,
                  footer: editable
                      ? [
                          buildAddButton(
                            onAddPress: () {
                              int newTabs = text
                                  .where((s) => s.startsWith("New tab"))
                                  .length;
                              text.add(
                                  "New tab ${newTabs == 0 ? "" : newTabs}");
                              setState(
                                () {
                                  tabs.add(
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
        ),
      ),
    );
  }
}
