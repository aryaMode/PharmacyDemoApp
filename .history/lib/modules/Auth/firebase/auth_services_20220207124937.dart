import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static signin({
    required String email,
    required String password,
    required BuildContext context,
    String? location,
    String? role,
  }) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
      ref
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$e"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }
}
