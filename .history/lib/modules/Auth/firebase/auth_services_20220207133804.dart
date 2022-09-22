import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static DatabaseReference ref = database.ref("users");

  Future<void> authSignin({
    required String email,
    required String password,
    required BuildContext context,
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

  Future<void> getCurrentUserInfo({required String uid}) {
    Query? 
  }

  Future<void> authSignUp({
    required String email,
    required String password,
    required BuildContext context,
    String? location,
    bool? role,
  }) async {
    try {
      UserCredential userInfo = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = userInfo.user!.uid;
      ref.update({
        uid: {
          "role": role,
          "location": location,
        }
      });
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
