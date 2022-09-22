import 'dart:convert';

class Img {
  String? url;
  String? name;
  int? index;

  Img({
    this.url,
    this.name,
    this.index,
  });
  
  factory Img.indexedImg({
    required int index,
    String? url,
    String? path,
  }) {
    return Img(
      index: index,
      url: url,
      name: path,
    );
  }

  Img copyWith({
    String? url,
    String? path,
    int? index,
  }) {
    return Img(
      url: url ?? this.url,
      name: path ?? this.name,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'path': name,
      'index': index,
    };
  }

  factory Img.fromMap(Map<String, dynamic> map) {
    return Img(
      url: map['url'],
      name: map['path'],
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
        other.path == path &&
        other.index == index;
  }

  @override
  int get hashCode => url.hashCode ^ path.hashCode ^ index.hashCode;
}
