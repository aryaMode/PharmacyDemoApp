import 'package:demo_catalog_app/constants/data.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final Img? image;
  final double opacity;
  final BoxFit fit;
  final bool scaleEnabled;
  const ImageWidget({
    Key? key,
    this.opacity = 1,
    this.fit = BoxFit.scaleDown,
    this.image,
    this.scaleEnabled = true,
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
    bool scaleEnabled = widget.scaleEnabled &&
        widget.image != null &&
        widget.image!.url != null;
    return GestureDetector(
      onDoubleTap: scaleEnabled ? _handleDoubleTap : () => {},
      onDoubleTapDown: scaleEnabled ? _handleDoubleTapDown : (details) => {},
      child: InteractiveViewer(
        scaleEnabled: scaleEnabled,
        transformationController: _transformationController,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: widget.fit,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(widget.opacity), BlendMode.dstATop),
              image: (widget.image != null
                  ? (widget.image!.url != null
                      ? (!kIsWeb
                          ? FirebaseImage(
                              "$kGSURL/images/${widget.image!.name}",
                              maxSizeBytes: 4000000,
                            )
                          : Image.network(
                              widget.image!.url!,
                            ).image)
                      : Image.asset(
                          widget.image!.assetPath ?? kUploadImage,
                        ).image)
                  : Image.asset(
                      kUploadImage,
                    ).image),
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
        image: image ?? widget.image,
        opacity: opacity ?? widget.opacity,
        fit: fit ?? widget.fit);
  }
}
