import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/widgets/image_picker.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/page_index_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_remove_icon_row.dart';

PageController pageController = new PageController(initialPage: 0);

class ScrollableImages extends ConsumerWidget {
  final int currentPageIndex;
  final void Function(int)? onPageChange;
  final void Function()? onAdd, onDelete;
  final List<ImageWidget>? images;

  const ScrollableImages({
    Key? key,
    required this.currentPageIndex,
    this.onPageChange,
    this.images,
    this.onAdd,
    this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final editable = ref.watch(editableProvider)
    PageView imagePageView = PageView.builder(
      controller: pageController,
      itemCount: images != null ? images!.length : 1,
      scrollDirection: Axis.horizontal,
      onPageChanged: onPageChange,
      itemBuilder: (BuildContext context, int index) {
        index = currentPageIndex;
        return !editable
            ? (images == null ? ImageWidget(image: Img()) : images![index])
            : (images == null
                ? ImagePicker()
                : ImagePicker(image: images![index]));
      },
    );
    Container pageIndexRow = Container(
      margin: EdgeInsets.only(
        bottom: getScreenHeight(context) * .05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: images != null
            ? List.generate(
                images!.length,
                (index) => currentPageIndex == index
                    ? pageIndexIndicator(true)
                    : pageIndexIndicator(false))
            : [SizedBox()],
      ),
    );
    return Stack(
      children: [
        imagePageView,
        images?.length == 1
            ? SizedBox.shrink()
            : Align(
                alignment: Alignment.bottomCenter,
                child: pageIndexRow,
              ),
        !editable
            ? SizedBox.shrink()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: getScreenHeight(context) * .03),
                  child: AddRemoveIconRow(
                    listLength: images?.length,
                    onAdd: onAdd,
                    onDelete: onDelete,
                  ),
                ),
              )
      ],
    );
  }
}
