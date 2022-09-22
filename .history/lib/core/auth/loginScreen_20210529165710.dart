import 'package:demo_catalog_app/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prince_care/constants.dart';


class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
    child: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
        child: Center(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Text("😁"),
                ),
                ),
                SizedBox(
          height: 48.0,
                ),
                TextFormField(
          validator: EmailValidator.validate,
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          onChanged: (value) {
          email = value;
          },
          decoration: kTextFieldDecoration.copyWith(
            hintText: 'Enter your email'),
                ),
                SizedBox(
          height: 8.0,
                ),
                TextField(
          obscureText: true,
          textAlign: TextAlign.center,
          onChanged: (value) {
          password = value;
          },
          decoration: kTextFieldDecoration.copyWith(
            hintText: 'Enter your password'),
                ),
                SizedBox(
          height: 24.0,
                ),
                RoundedButton(
          title: 'Log In',
          colour: Colors.lightBlueAccent,
          onPressed: () async {
     
          },
                ),
              ],
            ),
        ),
      ),
    ),
        ),
      );
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}
