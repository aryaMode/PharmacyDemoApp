import 'package:demo_catalog_app/main.dart';
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
  Widget build(BuildContext context,WidgetRef ref) {
    return FutureBuilder<User?>(

      future: FirebaseAuth.instance.authStateChanges().last,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ref.r
          print(snapshot.data);
          return DemoCatalogApp();
        }

        return Signin();
      },
    );
  }
}
