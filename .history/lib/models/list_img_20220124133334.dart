import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';

class ListImg extends Img {
  int index;
  ListImg({
    required this.index,
  }): super;

  ListImg copyWith({
    int? index,
  }) {
    return ListImg(
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
    };
  }

  factory ListImg.fromMap(Map<String, dynamic> map) {
    return ListImg(
      index: map['index']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListImg.fromJson(String source) => ListImg.fromMap(json.decode(source));

  @override
  String toString() => 'ListImg(index: $index)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ListImg &&
      other.index == index;
  }

  @override
  int get hashCode => index.hashCode;
}
