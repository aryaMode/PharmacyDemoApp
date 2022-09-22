import 'dart:html';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:demo_catalog_app/utils/helper/image_helper.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import "package:universal_html/html.dart"

class ImagePicker extends StatelessWidget {
  final void Function(File newImg)? onTap;
  final Img? image;
  const ImagePicker({
    this.image,
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //TODO: implement File.io for android device admins
        onTap: () async {
          //! changed from html.File
          File? testImage = await pickWebImage();
          if (testImage != null) {
            if (onTap != null) {
              onTap!(testImage);
            }
          }
        },
        child: ImageWidget(image: image));
  }
}
