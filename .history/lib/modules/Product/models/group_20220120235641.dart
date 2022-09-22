import 'dart:convert';

import 'package:demo_catalog_app/modules/Product/models/product.dart';


@freezed
abstract class Group with _$Group{
  const factory Group({
    
  }) = _Group;
}

// class Group {
//   String name;
//   List<Product> products;

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
//       'products': products.map((x) => x.toMap()).toList(),
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
//       name: map['name'] ?? '',
//       products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

//   @override
//   String toString() => 'Group(name: $name, products: $products)';

// }
