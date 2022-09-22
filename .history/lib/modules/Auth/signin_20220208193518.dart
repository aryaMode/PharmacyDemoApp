import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/signup.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_button.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_page_template.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_form_field.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_rich_text.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        
          child: AuthPageTemplate(
            child: Stack(
                  children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: kSecondaryColor,
            ),
            Align(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.asset(kCompanyLogo),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomFormField(
                      hintText: "Email",
                      obsecureText: false,
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      hintText: "Password",
                      obsecureText: _obscureText,
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: _obscureText ? Colors.grey : kSecondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          }),
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    AuthButton(
                      onTap: () {
                        print("Email:$email \n Password: $password");
                        auth.signInWithEmailAndPassword(
                            email: email, password: password);
                      },
                      text: 'Sign In',
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    AuthButton(
                      onTap: () {
                        // auth.signOut();
                        AuthServices()
                            .getCurrentUserInfo(uid: auth.currentUser!.uid);
                      },
                      text: 'Sign Out',
                    ),
                    CustomRichText(
                      discription: "Don't already Have an account? ",
                      text: "Sign Up",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                    ),
                  ],
                ),
              ),
            ),
                  ],
                ),
          )),
    );
  }
}

