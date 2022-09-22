import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/modules/Auth/signin.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/widgets/drop_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart' as a;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String get userName => _userName.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get userLocation => dropDownValue;
  String dropDownValue = "Gujarat";
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    height: 16 * 2,
                  ),
                  CustomFormField(
                    hintText: "Email",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    controller: _passwordController,
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: getScreenWidth(context) * 0.50,
                    child: DropDown(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 2),
                      value: dropDownValue,
                      onChanged: (changedValue) {
                        setState(() {
                          dropDownValue = changedValue.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AuthButton(
                    text: 'Sign Up',
                    onTap: () {},
                  ),
                  AuthButton(
                    onTap: () {
                    },
                    text: 'Sign Out',
                  ),
                  CustomRichText(
                    discription: 'Already Have an account? ',
                    text: 'Log In here',
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signin()));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
