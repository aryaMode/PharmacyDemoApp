import 'package:demo_catalog_app/main.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/provider.dart';
import 'package:demo_catalog_app/modules/Auth/signin.dart';
import 'package:demo_catalog_app/modules/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ref.read(userProvider.state).update((user) {
            var currentUser = await AuthServices().getCurrentUserInfo(uid: "");
            user = AuthUser.fromMap();
            return user;
          });
          // currentUser = await AuthUser.fromMap(AuthServices().getCurrentUserInfo(uid: ""));

          return Signin();
        }

        return SignUp();
      },
    );
  }
}
