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

  factory Img.fromMap(Map<String, dynamic> map) {
    return Img(
      url: map['url'],
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Img.fromJson(String source) => Img.fromMap(json.decode(source));

  @override
  String toString() => 'Img(url: $url, path: $path)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Img &&
      other.url == url &&
      other.path == path;
  }

  @override
  int get hashCode => url.hashCode ^ path.hashCode;
}
