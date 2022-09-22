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

  Img copyWith({
    String? url,
    String? path,
  }) {
    return Img(
      url: url ?? this.url,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'path': path,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      url: map['url'],
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));

  @override
  String toString() => 'Image(url: $url, path: $path)';
}
