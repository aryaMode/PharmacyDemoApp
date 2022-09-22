import 'dart:convert';


class Img {
  String? url;
  String? path;
  
  Img({
    this.url,
    this.path,
  });

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
}
