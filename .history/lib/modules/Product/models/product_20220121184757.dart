import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';
import 'package:uuid/uuid.dart';

class Product {
  String name;
  String id;
  String? tagline;
  List<Img> images;
  Img? logo;
  Img? offer;
  Img? other;

  Product({
    required this.id,
    required this.name,
    this.tagline,
    required this.images,
    this.logo,
    this.offer,
    this.other,
  });

  factory Product.emptyProduct() {
    return Product(
      id: Uuid()
      images: [Img()],
      name: "Untitled Product",
    );
  }

  Product copyWith({
    String? name,
    String? tagline,
    List<Img>? images,
    Img? logo,
    Img? offer,
    Img? other,
  }) {
    return Product(
      name: name ?? this.name,
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
      'tagline': tagline,
      'images': images.map((x) => x.toMap()).toList(),
      'logo': logo?.toMap(),
      'offer': offer?.toMap(),
      'other': other?.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      tagline: map['tagline'],
      images: List<Img>.from(map['images']?.map((x) => Img.fromMap(x))),
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
    return 'Product(name: $name, tagline: $tagline, images: $images, logo: $logo, offer: $offer, other: $other)';
  }
}
