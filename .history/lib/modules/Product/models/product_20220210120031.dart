import 'dart:collection';
import 'dart:convert';

import 'package:demo_catalog_app/modules/Product/models/location_image.dart';
import 'package:uuid/uuid.dart';

import 'package:demo_catalog_app/models/img.dart';

class Product {
  String name;
  String id;
  int index;
  String? tagline;
  SplayTreeMap<String, Img> images;
  SplayTreeMap<String, LocationImage> priceList;
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

  factory Product.emptyProduct({required int index}) {
    return Product(
      index: index,
      id: Uuid().v4(),
      images: SplayTreeMap<String, Img>.from(
        {
          Uuid().v4(): Img(index: 0),
        },
      ),
      name: "Untitled Product",
    );
  }

  Product copyWith({
    String? name,
    String? id,
    int? index,
    String? tagline,
    SplayTreeMap<String, Img>? images,
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
      'images': images.map((key, value) => MapEntry(key, value.toMap())),
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
      images: SplayTreeMap<String, Img>.from(
        map['images'].map((key, value) => MapEntry(key, Img.fromMap(value))),
        (String a, String b) {
          return map['images'][a]['index'] - map['images'][b]['index'];
        },
      ),
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
  bool operator ==(Object obj) {
    if (identical(this, obj)) return true;

    return obj is Product &&
        obj.name == name &&
        obj.id == id &&
        obj.index == index &&
        obj.tagline == tagline &&
        obj.images == images &&
        obj.logo == logo &&
        obj.offer == offer &&
        obj.other == other;
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
