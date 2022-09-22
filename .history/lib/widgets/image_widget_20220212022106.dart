
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
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
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final _transformationController = TransformationController();

  late TapDownDetails _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(1.75);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      onDoubleTapDown: _handleDoubleTapDown,
      child: InteractiveViewer(
        transformationController: _transformationController,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: widget.fit,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(widget.opacity), BlendMode.dstATop),
              image: (widget.image != null
                      ? (widget.image!.url != null
                          //TODO: implement FileImage
                          ? Firebase
                          // Image.network(widget.image!.url!)
                          : Image.asset(
                              widget.image!.assetPath ?? kUploadImage))
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
        image: image ?? this.widget.image,
        opacity: opacity ?? this.widget.opacity,
        fit: fit ?? this.widget.fit);
  }
}
