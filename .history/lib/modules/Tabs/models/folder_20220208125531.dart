import 'dart:collection';
import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';
import 'package:uuid/uuid.dart';

class Folder {
  int index;
  String name;
  Img? backgroundImage;
  SplayTreeMap<String, Img>? images;
  Folder({
    required this.images,
    required this.index,
    required this.name,
    this.backgroundImage,
  });

  factory Folder.emptyFolder({required int index}) {
    return Folder(
      index: index,
      images: SplayTreeMap<String, Img>.from(
        {
          Uuid().v4(): Img(index: 0),
        },
      ),
      name: "Untitled Folder",
    );
  }

  Folder copyWith({
    SplayTreeMap<String, Img>? images,
    int? index,
    String? name,
    Img? backgroundImage,
  }) {
    return Folder(
      images: images ?? this.images,
      index: index ?? this.index,
      name: name ?? this.name,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'images': images?.map((key, value) {
        return MapEntry(key, value.toMap());
      }),
      'index': index,
      'name': name,
      'backgroundImage': backgroundImage?.toMap(),
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      images: SplayTreeMap<String, Img>.from(
        map['images']?.map((key, value) => MapEntry(key, Img.fromMap(value))),
        (String a, String b) {
          return map['images'][a]['index'] - map['images'][b]['index'];
        },
      ),
      index: map['index']?.toInt() ?? 0,
      name: map['name'] ?? '',
      backgroundImage: map['backgroundImage'] != null
          ? Img.fromMap(map['backgroundImage'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Folder.fromJson(String source) => Folder.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Folder(images: $images, index: $index, name: $name, backgroundImage: $backgroundImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Folder &&
        other.images == images &&
        other.index == index &&
        other.name == name &&
        other.backgroundImage == backgroundImage;
  }

  @override
  int get hashCode {
    return images.hashCode ^
        index.hashCode ^
        name.hashCode ^
        backgroundImage.hashCode;
  }
}
