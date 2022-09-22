import 'dart:io';

import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/widgets/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Img? image;
  final double opacity;
  final BoxFit fit;
  final void Function(PlatformFile pickedFile)? onTap;
  const ImageWidget({
    Key? key,
    this.opacity = 1,
    this.fit = BoxFit.scaleDown,
    this.image, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImagePicker(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: fit,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(opacity), BlendMode.dstATop),
            image: (image != null
                    ? (image!.url != null
                        //TODO: implement FileImage
                        ? Image.network(image!.url!)
                        : Image.asset(image!.assetPath ?? kUploadImage))
                    : Image.asset(kUploadImage))
                .image,
          ),
        ),
      ),
    );
  }

  ImageWidget copyWith({
    Img? image,
    double? opacity,
    BoxFit? fit,
  }) {
    return ImageWidget(
        image: image ?? this.image,
        opacity: opacity ?? this.opacity,
        fit: fit ?? this.fit);
  }
}
