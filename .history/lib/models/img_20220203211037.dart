import 'dart:convert';

class Img {
  String? url;
  String? name;
  String? assetPath;
  int? index;

  Img({
    this.url,
    this.name,
    this.assetPath,
    this.index,
  });

  factory Img.indexedImg({
    required int index,
    String? assetPath,
    String? url,
    String? name,
  }) {
    return Img(
      assetPath: assetPath,
      index: index,
      url: url,
      name: name,
    );
  }

  Img copyWith({
    String? url,
    String? name,
    String? assetPath,
    int? index,
  }) {
    return Img(
      url: url ?? this.url,
      name: name ?? this.name,
      assetPath: assetPath ?? this.assetPath,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'assetPath': assetPath,
      'index': index,
    };
  }

  factory Img.fromMap(Map<String, dynamic> map) {
    return Img(
      url: map['url'],
      name: map['name'],
      assetPath: map['assetPath'],
      index: map['index']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Img.fromJson(String source) => Img.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Img(url: $url, name: $name, assetPath: $assetPath, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Img &&
      other.url == url &&
      other.name == name &&
      other.assetPath == assetPath &&
      other.index == index;
  }

  @override
  int get hashCode {
    return url.hashCode ^
      name.hashCode ^
      assetPath.hashCode ^
      index.hashCode;
  }
}
