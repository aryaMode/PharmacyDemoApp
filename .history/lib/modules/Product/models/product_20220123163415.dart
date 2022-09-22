import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:demo_catalog_app/models/img.dart';

class Product {
  String name;
  String id;
  int index;
  String? tagline;
  SplayTreeMap<String,Img> images;
  Img? logo;
  Img? offer;
  Img? other;

  Product({
    required this.name,
    required this.id,
    required this.index,
    this.tagline,
    required this.images,
    this.logo,
    this.offer,
    this.other,
  });

  // factory Product.emptyProduct({required int index}) {
  //   return Product(
  //     index: index,
  //     id: Uuid().v4(),
  //     images: [Img(index: 0)],
  //     name: "Untitled Product",
  //   );
  // }

  Product copyWith({
    String? name,
    String? id,
    int? index,
    String? tagline,
    SplayTreeMap<String,Img>? images,
    Img? logo,
    Img? offer,
    Img? other,
  }) {
    return Product(
      name: name ?? this.name,
      id: id ?? this.id,
      index: index ?? this.index,
      tagline: tagline ?? this.tagline,
      images: images ?? this.images,
      logo: logo ?? this.logo,
      offer: offer ?? this.offer,
      other: other ?? this.other,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'index': index,
      'tagline': tagline,
      'images': images.toMap(),
      'logo': logo?.toMap(),
      'offer': offer?.toMap(),
      'other': other?.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      index: map['index']?.toInt() ?? 0,
      tagline: map['tagline'],
      images: SplayTreeMap<String,Img>.fromMap(map['images']),
      logo: map['logo'] != null ? Img.fromMap(map['logo']) : null,
      offer: map['offer'] != null ? Img.fromMap(map['offer']) : null,
      other: map['other'] != null ? Img.fromMap(map['other']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, id: $id, index: $index, tagline: $tagline, images: $images, logo: $logo, offer: $offer, other: $other)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.name == name &&
      other.id == id &&
      other.index == index &&
      other.tagline == tagline &&
      other.images == images &&
      other.logo == logo &&
      other.offer == offer &&
      other.other == other;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        index.hashCode ^
        tagline.hashCode ^
        images.hashCode ^
        logo.hashCode ^
        offer.hashCode ^
        other.hashCode;
  }
}
