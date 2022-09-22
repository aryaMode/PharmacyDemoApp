

import 'dart:io';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/image_helper.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import "package:universal_html/html.dart" as html;

class ImagePicker extends StatelessWidget {
  final void Function(File pickedFile)? onTap;
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
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );

        if (result != null) {
          File file = File(result!.files.single.path);
        }

        //! changed from html.File
        File? pickedFile = await pickWebImage();
        if (pickedFile != null) {
          if (onTap != null) {
            onTap!(pickedFile);
          }
        }
      },
      child: ImageWidget(image: image),
    );
  }
}
