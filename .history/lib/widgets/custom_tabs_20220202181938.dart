import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/reorderable_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTabs extends ConsumerWidget {
  final List<Widget> filledOutlineButtonList;
  final Function(int oldIndex, int newIndex) onReorder;
  final List<Widget> footer;

  const CustomTabs({
    this.filledOutlineButtonList = const [],
    required this.onReorder,
    Key? key,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(filledOutlineButtonList.length);
    print(footer.length);
    bool editable = ref.watch(editableProvider);
    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.only(
        top: 0,
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: ReorderableLayout(
        footer: footer,
        onReorder: onReorder,
        reorderable: editable,
        children: filledOutlineButtonList,
        padding: EdgeInsets.all(kDefaultPadding / 2),
        crossAxisCount: filledOutlineButtonList.length +
            (footer != null ? (footer.length : 0),
        childAspectRatio: getAspectRatio(context,
            aspectRatio: 12 / (filledOutlineButtonList.length)),
      ),
    );
  }
}
