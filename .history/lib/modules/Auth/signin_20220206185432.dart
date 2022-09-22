import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/signup.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    AuthUser.fromMap({
      "uid": {"email": "test@gmail.com", "name": "Arya", "role": "admin"}
    });
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
                    height: 24,
                  ),
                  CustomFormField(
                    hintText: "Email",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: _emailController,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
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
                      print("""Email $email
                      Password $password""");
                    },
                    text: 'Sign In',
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
      )),
    );
  }
}

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;

  const CustomFormField(
      {Key? key,
      required this.hintText,
      required this.obsecureText,
      required this.suffixIcon,
      required this.textInputType,
      required this.textInputAction,
      required this.controller,
      required this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: getScreenWidth(context) * 0.56,
          margin: const EdgeInsets.symmetric(horizontal: 150),
          decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              maxLines: maxLines,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              obscureText: obsecureText,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: hintText,
                  isDense: true,
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  border: InputBorder.none,
                  suffixIcon: suffixIcon),
            ),
          ),
        )
      ],
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const AuthButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.122,
        height: MediaQuery.of(context).size.height * 0.05,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: TextWidget(
            text: text,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String discription;
  final String text;
  final Function() onTap;
  const CustomRichText(
      {Key? key,
      required this.discription,
      required this.text,
      required this.onTap})
      : super(key: key);
// "Don't already Have an account? "
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16 * 3),
      child: Text.rich(
        TextSpan(
            text: discription,
            style: const TextStyle(color: Colors.black87, fontSize: 16),
            children: [
              TextSpan(
                  text: text,
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTap),
            ]),
      ),
    );
  }
}
