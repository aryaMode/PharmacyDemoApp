import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static signin({
    required String email,
    required String password,
    String? location,
    String? role,
  }) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      
    }
  }
}
