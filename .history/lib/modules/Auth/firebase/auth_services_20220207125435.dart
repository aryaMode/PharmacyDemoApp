import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static void signin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$e"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  static Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
    String? location,
    String? role,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

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
