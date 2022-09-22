import 'dart:collection';
import 'dart:convert';

import 'package:universal_html/html.dart';

import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';
import 'package:demo_catalog_app/modules/Tabs/models/locationFolders.dart';

class Tab {
  String name;
  SplayTreeMap<String, LocationFolders> locationFolders;
  int index;
  Tab({
    required this.name,
    required this.locationFolders,
    required this.index,
  });

  Tab copyWith({
    String? name,
    SplayTreeMap<String, LocationFolders>? locationfolders,
    int? index,
  }) {
    return Tab(
      name: name ?? this.name,
      locationFolders: locationfolders ?? this.locationFolders,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'locationfolders': locationFolders.map((key, value) => MapEntry(key, value.toMap())),
      'index': index,
    };
  }

  factory Tab.fromMap(Map<String, dynamic> map) {
    return Tab(
      name: map['name'] ?? '',
      locationFolders: SplayTreeMap<String, LocationFolders>.from(
        map["locationfolders"].map(
          (key, value) => MapEntry(
            key,
            Product.fromMap(value),
          ),
        ),
        (String a, String b) {
          return map["products"][a]["index"] - map["products"][b]["index"];
        },
      ),
      index: map['index']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tab.fromJson(String source) => Tab.fromMap(json.decode(source));

  @override
  String toString() => 'Tab(name: $name, locationfolders: $locationFolders, index: $index)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Tab &&
      other.name == name &&
      other.locationFolders == locationFolders &&
      other.index == index;
  }

  @override
  int get hashCode => name.hashCode ^ locationFolders.hashCode ^ index.hashCode;
}
