import 'dart:convert';

class AuthUser {
  String? uid;
  String? role;
  String? location;
  
  AuthUser({
    this.uid,
    this.role,
    this.location,
  });

  AuthUser copyWith({
    String? uid,
    String? role,
    String? location,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      role: role ?? this.role,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'role': role,
      'location': location,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      uid: map['uid'],
      role: map['role'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) => AuthUser.fromMap(json.decode(source));

  @override
  String toString() => 'AuthUser(uid: $uid, role: $role, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthUser &&
      other.uid == uid &&
      other.role == role &&
      other.location == location;
  }

  @override
  int get hashCode => uid.hashCode ^ role.hashCode ^ location.hashCode;
}
