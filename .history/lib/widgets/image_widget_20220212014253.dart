import 'dart:io';

import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageWidget extends StatelessWidget {
  final Img? image;
  final double opacity;
  final BoxFit fit;
  const ImageWidget({
    Key? key,
    this.opacity = 1,
    this.fit = BoxFit.scaleDown,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Fit(
          child: PhotoView(
            
              backgroundDecoration: BoxDecoration(
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
        ));
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

// PhotoView(
//               backgroundDecoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//               minScale: PhotoViewComputedScale.contained * 1,
//               maxScale: PhotoViewComputedScale.contained * 1.8,
//               imageProvider: MemoryImage(widget.imageBytes.data == null
//                   ? toImageBytes(kUploadImage)
//                   : widget.imageBytes.data),
//             ),