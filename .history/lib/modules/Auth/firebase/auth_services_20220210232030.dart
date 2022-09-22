import 'package:demo_catalog_app/utils/helper/conversion.dart';
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
      await auth.signInWithEmailAndPassword(email: email, password: password);

  }

  Future<Map<String, dynamic>> getCurrentUserInfo({required String uid}) async {
    Query? usersQuery = ref.orderByChild("uid").equalTo(uid);
    Map<String, dynamic> userInfo;
    await usersQuery.get().then((usersSnapshot) async {
      for (DataSnapshot userSnapshot in usersSnapshot.children) {
        userInfo = objectConversion(userSnapshot.value);
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
  
      UserCredential userInfo = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
          if(userInfo.user != null){
         
      String uid = userInfo.user!.uid;


      ref.set({
        Uuid().v4(): {
          "uid": uid,
          "admin": admin,
          "location": location,
        }
      });

          }

  
  }
}
