import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static signin({

  }
    try {
      String email, String password, String location, String role) {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {}
  }
}
