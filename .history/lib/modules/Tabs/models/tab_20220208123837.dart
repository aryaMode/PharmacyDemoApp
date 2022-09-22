import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Tabs/models/location_folders.dart';

class Tab {
  String name;
  Map<String, LocationFolders> locationFolders;
  int index;
  Tab({
    required this.name,
    required this.locationFolders,
    required this.index,
  });

  factory Tab.emptyTab({
    required int index,
    String? name,
  }) {
    return Tab(
      index: index,
      locationFolders: SplayTreeMap<String, LocationFolders>.from(
        Locations.locations.asMap().map(
              (index, location) => MapEntry<String, LocationFolders>(
                Uuid().v4(),
                LocationFolders.emptyLocationFolders(location),
              ),
            ),
      ),
      name: name ?? 'Untitled tab',
    );
  }
  Tab copyWith({
    String? name,
    Map<String, LocationFolders>? locationFolders,
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
      locationFolders: Map<String, LocationFolders>.from(
        map["locationFolders"].map(
          (key, value) => MapEntry(
            key,
            LocationFolders.fromMap(value),
          ),
        ),
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
        mapEquals(other.locationFolders, locationFolders) &&
        other.index == index;
  }

  @override
  int get hashCode => name.hashCode ^ locationFolders.hashCode ^ index.hashCode;
}
