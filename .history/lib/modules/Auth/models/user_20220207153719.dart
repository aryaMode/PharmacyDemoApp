import 'dart:convert';

class AuthUser {
  bool? admin;
  String? location;
  String? uid;
  
  AuthUser({
    this.admin,
    this.location,
    this.uid,
  });

  AuthUser copyWith({
    String? admin,
    String? location,
    String? uid,
  }) {
    return AuthUser(
      admin: admin ?? this.admin,
      location: location ?? this.location,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'admin': admin,
      'location': location,
      'uid': uid,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      admin: map['admin'],
      location: map['location'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) => AuthUser.fromMap(json.decode(source));

  @override
  String toString() => 'AuthUser(admin: $admin, location: $location, uid: $uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthUser &&
      other.admin == admin &&
      other.location == location &&
      other.uid == uid;
  }

  @override
  int get hashCode => admin.hashCode ^ location.hashCode ^ uid.hashCode;
}
