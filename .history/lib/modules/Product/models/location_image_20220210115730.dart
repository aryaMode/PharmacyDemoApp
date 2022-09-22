
import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';

class LocationImage {
  Img? image;
  String location;
  LocationImage({
    this.image,
    required this.location,
  });

  LocationImage copyWith({
    Img? image,
    String? location,
  }) {
    return LocationImage(
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

  factory LocationImage.fromMap(Map<String, dynamic> map) {
    return LocationImage(
      image: map['image'] != null ? Img.fromMap(map['image']) : null,
      location: map['location'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationImage.fromJson(String source) => LocationImage.fromMap(json.decode(source));

  @override
  String toString() => 'LocationImages(image: $image, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LocationImage &&
      other.image == image &&
      other.location == location;
  }

  @override
  int get hashCode => image.hashCode ^ location.hashCode;
}
