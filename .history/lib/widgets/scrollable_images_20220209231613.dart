import 'dart:io';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/image_picker.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:demo_catalog_app/widgets/page_index_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_remove_icon_row.dart';

class ScrollableImages extends ConsumerStatefulWidget {
  final Future<void> Function(int index)? onAdd, onDelete;
  final List<Img>? images;
  final Future<void> Function(
    int index,
    PlatformFile newImageFile,
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
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final editable = ref.watch(editableProvider);
    PageView imagePageView = PageView.builder(
      controller: pageController,
      itemCount: widget.images?.length,
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
                onTap: (newImageFile) async {
                  if (widget.onEdit != null) {
                    await widget.onEdit!(index, newImageFile);
                  }
                },
                image: widget.images?[index],
                ),
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
                    onAdd: () async {
                      if (widget.onAdd != null) {
                        await widget.onAdd!(currentIndex);
                      }
                      currentIndex = currentIndex + 1;
                      await pageController.animateToPage(
                        currentIndex,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    },
                    onDelete: () async {
                      if (widget.onDelete != null) {
                        await widget.onDelete!(currentIndex);
                      }
                      currentIndex -= (currentIndex != 0 ? 1 : 0);
                      pageController.animateToPage(
                        currentIndex,
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
