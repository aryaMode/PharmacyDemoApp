import 'dart:convert';

class User {
  String? email;
  String? role;
  String? location;
  User({
    this.email,
    this.role,
    this.location,
  });

  User copyWith({
    String? email,
    String? role,
    String? location,
  }) {
    return User(
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      role: map['role'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(email: $email, role: $role, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.email == email &&
      other.role == role &&
      other.location == location;
  }

  @override
  int get hashCode => email.hashCode ^ role.hashCode ^ location.hashCode;
}
