import 'dart:convert';

class Img {
  String? url;
  String? path;
  int? index;

  Img({
    this.url,
    this.path,
    this.index,
  });
  Img.
  Img copyWith({
    String? url,
    String? path,
    int? index,
  }) {
    return Img(
      url: url ?? this.url,
      path: path ?? this.path,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'path': path,
      'index': index,
    };
  }

  factory Img.fromMap(Map<String, dynamic> map) {
    return Img(
      url: map['url'],
      path: map['path'],
      index: map['index']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Img.fromJson(String source) => Img.fromMap(json.decode(source));

  @override
  String toString() => 'Img(url: $url, path: $path, index: $index)';

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
