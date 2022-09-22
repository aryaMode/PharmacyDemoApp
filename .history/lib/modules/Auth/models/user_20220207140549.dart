import 'dart:convert';

class AuthUser {
  String? uid;
  String? admin;
  String? location;
  
  AuthUser({
    this.uid,
    this.admin,
    this.location,
  });

  AuthUser copyWith({
    String? uid,
    String? role,
    String? location,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      admin: role ?? this.admin,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'role': admin,
      'location': location,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      uid: map['uid'],
      admin: map['role'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) => AuthUser.fromMap(json.decode(source));

  @override
  String toString() => 'AuthUser(uid: $uid, role: $admin, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthUser &&
      other.uid == uid &&
      other.admin == admin &&
      other.location == location;
  }

  @override
  int get hashCode => uid.hashCode ^ admin.hashCode ^ location.hashCode;
}
