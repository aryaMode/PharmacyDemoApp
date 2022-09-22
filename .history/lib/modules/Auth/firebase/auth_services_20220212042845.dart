import 'package:demo_catalog_app/utils/helper/conversion.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static DatabaseReference ref = FirebaseDBHelper.database.ref("users");

  Future<void> authSignin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<Map<String, dynamic>?> getCurrentUserInfo(
      {required String uid}) async {
    Query? usersQuery = ref.orderByChild("uid").equalTo(uid);
    Map<String, dynamic>? userInfo;
    await usersQuery.get().then(
      (usersSnapshot) async {
        for (DataSnapshot userSnapshot in usersSnapshot.children) {
          userInfo = objectConversion(userSnapshot.value);
        }
      },
    );

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
    if (userInfo.user != null) {
      String uid = userInfo.user!.uid;

      ref.set(
        {
          Uuid().v4(): {
            "uid": uid,
            "admin": admin,
            "location": location,
          }
        },
      );
    }
  }

  static Future<UserCredential?> register(String email, String password) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return null;
    }

    await app.delete();
    return Future.sync(() => userCredential);
  }
}
