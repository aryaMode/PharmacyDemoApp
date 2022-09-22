import 'dart:convert';

class AuthUser {
  String? uid;
  String? role;
  String? location;
  
  AuthUser({
    this.email,
    this.role,
    this.location,
  });

  AuthUser copyWith({
    String? email,
    String? role,
    String? location,
  }) {
    return AuthUser(
      email: email ?? this.email,
      role: role ?? this.role,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'location': location,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      email: map['email'],
      role: map['role'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) => AuthUser.fromMap(json.decode(source));

  @override
  String toString() => 'User(email: $email, role: $role, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthUser &&
      other.email == email &&
      other.role == role &&
      other.location == location;
  }

  @override
  int get hashCode => email.hashCode ^ role.hashCode ^ location.hashCode;
}
