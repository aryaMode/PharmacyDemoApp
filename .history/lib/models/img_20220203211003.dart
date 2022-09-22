import 'dart:convert';

class Img {
  String? url;
  String? name;
  String? assetPath;
  int? index;

  Img({
    this.url,
    this.name,
    this.index,
  });

  factory Img.indexedImg({
    required int index,
    String? url,
    String? name,
  }) {
    return Img(
      index: index,
      url: url,
      name: name,
    );
  }

  Img copyWith({
    String? url,
    String? name,
    int? index,
  }) {
    return Img(
      url: url ?? this.url,
      name: name ?? this.name,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'index': index,
    };
  }

  factory Img.fromMap(Map<String, dynamic> map) {
    return Img(
      url: map['url'],
      name: map['name'],
      index: map['index']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Img.fromJson(String source) => Img.fromMap(json.decode(source));

  @override
  String toString() => 'Img(url: $url, name: $name, index: $index)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Img &&
        other.url == url &&
        other.name == name &&
        other.index == index;
  }

  @override
  int get hashCode => url.hashCode ^ name.hashCode ^ index.hashCode;
}
