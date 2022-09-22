import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:demo_catalog_app/modules/Product/models/product.dart';
part 'group.freezed.dart';
part 'group.g.dart';

@freezed
abstract class Group with _$Group {
  const factory Group({
    String? name,
    List<Product>? products,
  }) = _Group;
}
factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
// class Group {
//   String? name;
//   List<Product>? products;

//   Group({
//     required this.name,
//     required this.products,
//   });

//   Group copyWith({
//     String? name,
//     List<Product>? products,
//   }) {
//     return Group(
//       name: name ?? this.name,
//       products: products ?? this.products,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'products': products?.map((x) => x?.toMap())?.toList(),
//     };
//   }

//   // factory Group.fromMap(Map<String, dynamic> map) {
//   //   return Group(
//   //     name: map['name'] ?? '',
//   //     products: map['products'] == null
//   //         ? <Product>[]
//   //         : List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
//   //   );
//   // }
//   factory Group.fromMap(Map<String, dynamic> map) {
//     return Group(
//       name: map['name'],
//       products: map['products'] != null ? List<Product>.from(map['products']?.map((x) => Product.fromMap(x))) : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

//   @override
//   String toString() => 'Group(name: $name, products: $products)';


//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is Group &&
//       other.name == name &&
//       listEquals(other.products, products);
//   }

//   @override
//   int get hashCode => name.hashCode ^ products.hashCode;
// }
