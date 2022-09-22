import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:demo_catalog_app/modules/Product/models/product.dart';

class Group {
  String name;
  List<Product> products;
  int index;

  Group({
    required this.name,
    required this.products,
    required this.index,
  });

  
  Group copyWith({
    String? name,
    List<Product>? products,
    int? index,
  }) {
    return Group(
      name: name ?? this.name,
      products: products ?? this.products,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'products': products.map((x) => x.toMap()).toList(),
      'index': index,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      name: map['name'] ?? '',
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
      index: map['index']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() => 'Group(name: $name, products: $products, index: $index)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Group &&
      other.name == name &&
      listEquals(other.products, products) &&
      other.index == index;
  }

  @override
  int get hashCode => name.hashCode ^ products.hashCode ^ index.hashCode;
}
