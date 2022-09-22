import 'dart:collection';
import 'dart:convert';

import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Tabs/models/locationFolders.dart';
import 'package:uuid/uuid.dart';

class Tab {
  String name;
  SplayTreeMap<String, LocationFolders> locationFolders;
  int index;
  Tab({
    required this.name,
    required this.locationFolders,
    required this.index,
  });

  factory Tab.emptyTab() {
    return Tab(
      index: 0,
      locationFolders: SplayTreeMap.from(Locations.locations.map((location)=>MapEntry(Uuid().v4(),LocationFolders.emptyLocationFolders(location)))),
      name: '',
    );
  }
  Tab copyWith({
    String? name,
    SplayTreeMap<String, LocationFolders>? locationFolders,
    int? index,
  }) {
    return Tab(
      name: name ?? this.name,
      locationFolders: locationFolders ?? this.locationFolders,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'locationFolders':
          locationFolders.map((key, value) => MapEntry(key, value.toMap())),
      'index': index,
    };
  }

  factory Tab.fromMap(Map<String, dynamic> map) {
    return Tab(
      name: map['name'] ?? '',
      locationFolders: SplayTreeMap<String, LocationFolders>.from(
        map["locationFolders"].map(
          (key, value) => MapEntry(
            key,
            LocationFolders.fromMap(value),
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
  String toString() =>
      'Tab(name: $name, locationFolders: $locationFolders, index: $index)';

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
