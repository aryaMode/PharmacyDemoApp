
import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';

class LocationImages {
  Img? image;
  String location;
  LocationImages({
    this.image,
    required this.location,
  });

  LocationImages copyWith({
    Img? image,
    String? location,
  }) {
    return LocationImages(
      image: image ?? this.image,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image?.toMap(),
      'location': location,
    };
  }

  factory LocationImages.fromMap(Map<String, dynamic> map) {
    return LocationImages(
      image: map['image'] != null ? Img.fromMap(map['image']) : null,
      location: map['location'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationImages.fromJson(String source) => LocationImages.fromMap(json.decode(source));

  @override
  String toString() => 'LocationImages(image: $image, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LocationImages &&
      other.image == image &&
      other.location == location;
  }

  @override
  int get hashCode => image.hashCode ^ location.hashCode;
}
