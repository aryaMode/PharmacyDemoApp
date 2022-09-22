import 'dart:collection';
import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';

class IntroImages {
  SplayTreeMap<String, Img>? images;
  IntroImages({
    this.images,
  });

  IntroImages copyWith({
    SplayTreeMap<String, Img>? images,
  }) {
    return IntroImages(
      images: images ?? this.images,
    );
  }

  factory IntroImages.emptyIntroImages() {
    return IntroImages(
      images: SplayTreeMap<String, Img>.from(
        {
          Uuid().v4(): Img(index: 0),
        },
      )
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'images': images?.toMap(),
    };
  }

  factory IntroImages.fromMap(Map<String, dynamic> map) {
    return IntroImages(
      images: map['images'] != null
          ? SplayTreeMap<String, Img>.fromMap(map['images'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IntroImages.fromJson(String source) =>
      IntroImages.fromMap(json.decode(source));

  @override
  String toString() => 'IntroImages(images: $images)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IntroImages && other.images == images;
  }

  @override
  int get hashCode => images.hashCode;
}
