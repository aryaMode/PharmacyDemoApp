import 'package:demo_catalog_app/utils/ui/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getCurrentUserInfo({required String uid}) async {
    Query? usersQuery = ref.orderByChild("uid").equalTo(uid);
    var userInfo;
    await usersQuery.get().then((usersSnapshot) async {
      for (DataSnapshot userSnapshot in usersSnapshot.children) {
        userInfo = (userSnapshot.value);
      }
    });

    return userInfo;
  }

  Future<void> authSignUp({
    required String email,
    required String password,
    required BuildContext context,
    String? location,
    bool? admin,
  }) async {
    try {
      UserCredential userInfo = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
          if(userInfo.user != null){
         
      String uid = userInfo.user!.uid;


      ref.update({
        Uuid().v4(): {
          "uid": uid,
          "admin": admin,
          "location": location,
        }
      });

          }

  
  }
}
