import 'package:demo_catalog_app/constants/colors.dart';
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
import 'package:demo_catalog_app/widgets/filled_outline_button.dart';
import 'package:demo_catalog_app/widgets/folder.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:demo_catalog_app/widgets/rounded_icon.dart';
import 'package:demo_catalog_app/widgets/scrollable_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

List<String> text = [for (int i = 0; i < 4; i++) "Tab $i"];

class _TabScreenState extends ConsumerState<TabScreen> {
  String dropDownValue = "Gujarat";
  IconData dustbinIcon = Icons.delete_outline_rounded;
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
          ),
        ],
      ),
      body: SafeArea(
        child: TabScreenBuilder(),
      ),
    );
  }
}

class TabScreenBuilder extends StatelessWidget {
  const TabScreenBuilder({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
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
                              int newTabs = text
                                  .where((s) => s.startsWith("New tab"))
                                  .length;
                              text.add(
                                  "New tab ${newTabs == 0 ? "" : newTabs}");
                              setState(
                                () {
                                  tabs?.add(
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
  }
}
