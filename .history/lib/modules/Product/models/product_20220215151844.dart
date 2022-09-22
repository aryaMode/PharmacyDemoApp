import 'dart:collection';
import 'dart:convert';

import 'package:demo_catalog_app/models/locations.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Product/models/location_image.dart';

class Product {
  String name;
  String id;
  int index;
  String? tagline;
  SplayTreeMap<String, Img> images;
  Map<String, LocationImage> priceList;
  Img? logo;
  Img? offer;
  Img? productInfo;

  Product({
    required this.name,
    required this.id,
    required this.index,
    this.tagline,
    required this.images,
    required this.priceList,
    this.logo,
    this.offer,
    this.productInfo,
  });

  factory Product.emptyProduct({required int index}) {
    return Product(
      index: index,
      id: const Uuid().v4(),
      images: SplayTreeMap<String, Img>.from(
        {
          const Uuid().v4(): Img(index: 0),
        },
      ),
      priceList: SplayTreeMap<String, LocationImage>.from(
        Locations.locations.asMap().map(
              (index, location) => MapEntry<String, LocationImage>(
                const Uuid().v4(),
                LocationImage.emptyLocationImage(location),
              ),
            ),
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
    Map<String, LocationImage>? priceList,
    Img? logo,
    Img? offer,
    Img? productInfo,
  }) {
    return Product(
      name: name ?? this.name,
      id: id ?? this.id,
      index: index ?? this.index,
      tagline: tagline ?? this.tagline,
      images: images ?? this.images,
      priceList: priceList ?? this.priceList,
      logo: logo ?? this.logo,
      offer: offer ?? this.offer,
      productInfo: productInfo ?? this.productInfo,
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
      'productInfo': productInfo?.toMap(),
      'priceList': priceList.map((key, value) => MapEntry(key, value.toMap())),
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
      productInfo:
          map['productInfo'] != null ? Img.fromMap(map['productInfo']) : null,
      priceList: Map<String, LocationImage>.from(
        map["priceList"].map(
          (key, value) => MapEntry(
            key,
            LocationImage.fromMap(value),
          ),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, id: $id, index: $index, tagline: $tagline, images: $images, priceList: $priceList, logo: $logo, offer: $offer, productInfo: $productInfo)';
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
        mapEquals(other.priceList, priceList) &&
        other.logo == logo &&
        other.offer == offer &&
        other.productInfo == productInfo;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        index.hashCode ^
        tagline.hashCode ^
        images.hashCode ^
        priceList.hashCode ^
        logo.hashCode ^
        offer.hashCode ^
        productInfo.hashCode;
  }
}
