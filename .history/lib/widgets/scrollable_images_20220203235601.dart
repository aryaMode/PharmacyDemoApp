import 'dart:html';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/image_picker.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/page_index_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_remove_icon_row.dart';

class ScrollableImages extends ConsumerStatefulWidget {
  final void Function()? onAdd, onDelete;
  final List<Img>? images;
  final void Function(
    int index,
    File newImageFile,
  )? onEdit;
  const ScrollableImages({
    this.onEdit,
    Key? key,
    this.images,
    this.onAdd,
    this.onDelete,
  }) : super(key: key);

  @override
  ConsumerState<ScrollableImages> createState() => _ScrollableImagesState();
}

class _ScrollableImagesState extends ConsumerState<ScrollableImages> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final editable = ref.watch(editableProvider);
    PageView imagePageView = PageView.builder(
      controller: pageController,
      itemCount: widget.images != null ? widget.images!.length : 1,
      scrollDirection: Axis.horizontal,
      onPageChanged: (val) {
        setState(() {
          currentIndex = val;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return !editable
            ? (ImageWidget(
                image: widget.images?[index],
              ))
            : (ImagePicker(
                onTap: (newImageFile) {
                  if (widget.onEdit != null) {
                    widget.onEdit!(index, newImageFile);
                  }
                },
                image: widget.images?[index],
              ));
      },
    );
    Container pageIndexRow = Container(
      margin: EdgeInsets.only(
        bottom: getScreenHeight(context) * .05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.images != null
            ? List.generate(
                widget.images!.length,
                (index) => currentIndex == index
                    ? pageIndexIndicator(true)
                    : pageIndexIndicator(false),
              )
            : [
                SizedBox(),
              ],
      ),
    );
    return Stack(
      children: [
        imagePageView,
        widget.images?.length == 1
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
                    listLength: widget.images?.length,
                    onAdd: () {
                      if (widget.onAdd != null) {
                        widget.onAdd!();
                        setState(
                          () {
                            pageController.animateToPage(
                              currentIndex + 1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                        );
                      }
                    },
                    onDelete: () {
                      if (widget.onDelete != null) {
                        widget.onDelete!();
                      }
                      pageIndexState
                            .update((state) => state != 0 ? state - 1 : state);

                        pageController.animateToPage(
                          pageIndexState.state,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                    },
                  ),
                ),
              )
      ],
    );
  }
}
