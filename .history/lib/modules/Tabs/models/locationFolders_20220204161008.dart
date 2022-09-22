import 'dart:collection';
import 'dart:convert';

import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';

class LocationFolders {
  String location;
  SplayTreeMap<String, Folder>? folders;
  LocationFolders({
    required this.location,
    this.folders,
  });

  LocationFolders copyWith({
    String? location,
    SplayTreeMap<String, Folder>? folders,
  }) {
    return LocationFolders(
      location: location ?? this.location,
      folders: folders ?? this.folders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'folders': folders?.map((key, value) => MapEntry(key, value.toMap())),
    };
  }

  factory LocationFolders.fromMap(Map<String, dynamic> map) {
    return LocationFolders(
      location: map['location'] ?? '',
      folders: map['folders'] != null ? SplayTreeMap<String, Folder>.from(
        map['location folders'].map((key, value) => MapEntry(key, Folder.fromMap(value))),
        (String a, String b) {
          return map['images'][a]['index'] - map['images'][b]['index'];
        },
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationFolders.fromJson(String source) => LocationFolders.fromMap(json.decode(source));

  @override
  String toString() => 'LocationFolders(location: $location, folders: $folders)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LocationFolders &&
      other.location == location &&
      other.folders == folders;
  }

  @override
  int get hashCode => location.hashCode ^ folders.hashCode;
}
