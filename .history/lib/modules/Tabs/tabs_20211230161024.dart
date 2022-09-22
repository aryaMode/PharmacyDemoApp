import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/constants/widgets.dart';
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
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class Tab extends StatefulWidget {
  const Tab({Key? key}) : super(key: key);

  @override
  _TabState createState() => _TabState();
}

List<String> text = [for (int i = 0; i < 4; i++) "Tab $i"];

class _TabState extends State<Tab> {
  bool editable = false;
  String dropDownValue = "Gujarat";
  IconData dustbinIcon = Icons.delete_outline_rounded;
  @override
  Widget build(BuildContext context) {
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
              width: ((MediaQuery.of(context).size.width / 12) * (6 / 4)),
              height: ((MediaQuery.of(context).size.height / 12) * (4 / 6)),
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
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 6,
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
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
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
                ),
              );
            },
          ),
        )
    ];
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
          // Draggable(
          //     data: "Mommy i did it",
          //     child: ElevatedIconButton(
          //       icon: Icons.add,
          //     ),
          //     feedback: Text("lu")),
          editable
              ? Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  height: 100,
                  width: 200,
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
          EditIcon(padding: kDefaultPadding/2,editable: editable,on)
          Container(
            margin: EdgeInsets.all(6),
            child: ElevatedIconButton(
              icon: Icons.edit,
              active: editable,
              onPressed: () {
                setState(() {
                  editable = !editable;
                });
              },
            ),
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
                    // TODO: Make different Custom Folders dart file
                    // TODO: make all sized box .shrink()
                    child: ReorderableLayout(
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height),
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
                    width: MediaQuery.of(context).size.width,
                    bottom: 30,
                    // left: MediaQuery.of(context).size.width / 2 - 27.5,
                    child: DragTarget(
                      builder: (BuildContext context,
                              List<Object?> candidateData,
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
                        print(data);
                      },
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
