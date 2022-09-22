import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';

class ListImg extends Img {
  int index;
  String? url;
  String? path;
  
  ListImg({
    required this.index,
  }:);

  ListImg copyWith({
    int? index,
    String? url,
    String? path,
  }) {
    return ListImg(
      index: index ?? this.index,
      url: url ?? this.url,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'url': url,
      'path': path,
    };
  }

  factory ListImg.fromMap(Map<String, dynamic> map) {
    return ListImg(
      index: map['index']?.toInt() ?? 0,
      url: map['url'],
      path: map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListImg.fromJson(String source) => ListImg.fromMap(json.decode(source));

  @override
  String toString() => 'ListImg(index: $index, url: $url, path: $path)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ListImg &&
      other.index == index &&
      other.url == url &&
      other.path == path;
  }

  @override
  int get hashCode => index.hashCode ^ url.hashCode ^ path.hashCode;
}
