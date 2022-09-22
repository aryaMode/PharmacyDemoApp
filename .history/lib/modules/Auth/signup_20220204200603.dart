import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/modules/Auth/signin.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get userName => _userName.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
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
                  
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
