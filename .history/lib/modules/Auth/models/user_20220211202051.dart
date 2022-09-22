import 'dart:convert';

class AuthUser {
  bool admin;
  String location;
  String uid;

  AuthUser({
    this.admin,
    this.location,
    this.uid,
  });
}
