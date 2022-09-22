import 'dart:convert';
import 'package:demo_catalog_app/widgets/image_widget.dart';

class Img {
  String? url;
  String? path;
  Img({
    this.url,
    this.path,
  });
  ImageWidget toWidget() {
    return ImageWidget(image: this);
  }
}
