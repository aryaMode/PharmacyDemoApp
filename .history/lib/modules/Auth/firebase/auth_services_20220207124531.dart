import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static signin({

      required String email,required String password, required String location, required String role
  }
      ) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {}
  }
}
