import 'dart:io';

import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails;
  final Img? image;
  final double opacity;
  final BoxFit fit;
  const ImageWidget({
    Key? key,
    this.opacity = 1,
    this.fit = BoxFit.scaleDown,
    this.image,
  }) : super(key: key);

void _handleDoubleTapDown(TapDownDetails details) {
  _doubleTapDetails = details;
}

void _handleDoubleTap() {
  if (_transformationController.value != Matrix4.identity()) {
    _transformationController.value = Matrix4.identity();
  } else {
    final position = _doubleTapDetails.localPosition;
    // For a 3x zoom
    _transformationController.value = Matrix4.identity()
      ..translate(-position.dx * 2, -position.dy * 2)
      ..scale(3.0);
    // Fox a 2x zoom
    // ..translate(-position.dx, -position.dy)
    // ..scale(2.0);
  }
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: ,
      child: InteractiveViewer(
        transformationController: _transformationController,
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


