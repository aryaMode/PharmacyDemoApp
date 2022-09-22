import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:flutter/material.dart';

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
    image = image??Img()
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: fit,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(opacity), BlendMode.dstATop),
              image: (image.url != null
                      ? Image.network(image.url!)
                      : Image.asset(image.path ?? kUploadImage))
                  .image)),
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
