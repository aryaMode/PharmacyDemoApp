import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/provider.dart';
import 'package:demo_catalog_app/modules/Auth/signin.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_button.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_page_template.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_form_field.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_rich_text.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/utils/ui/showSnackBar.dart';
import 'package:demo_catalog_app/widgets/drop_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get location => dropDownValue;

  String dropDownValue = "All";
  bool _obscureText = true;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: AuthPageTemplate(
              child: Column(
                children: [
                  CustomFormField(
                    hintText: "Email",
                    obsecureText: false,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  CustomFormField(
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
                  // const SizedBox(
                  //   height: kDefaultPadding,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (!isAdmin
                            ? <Widget>[
                                Container(
                                    width: getScreenWidth(context) * 0.50,
                                    child: DropDown(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding * 2),
                                      items: Locations.locations,
                                      value: Locations.locations[
                                          ref.watch(locationIndexProvider)],
                                      onChanged: (changedValue) {
                                        ref
                                                .read(locationIndexProvider.state)
                                                .state =
                                            (Locations.locations
                                                .indexOf(changedValue!));
                                      },
                                    )
                           
                                    ),
                              ]
                            : <Widget>[]) +
                        <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Column(
                              children: [
                                Checkbox(
                                  value: isAdmin,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      dropDownValue = "All";
                                      isAdmin = value!;
                                    });
                                  },
                                ),
                                Text(
                                  "Admin",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: !isAdmin
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  AuthButton(
                      text: 'Sign Up',
                      onTap: () async {
                        try {
                          await AuthServices()
                              .authSignUp(
                            email: email,
                            password: password,
                            context: context,
                            location: location,
                            admin: isAdmin,
                          )
                              .then((_) async {
                            var currentUser = await AuthServices()
                                .getCurrentUserInfo(
                                    uid: AuthServices.auth.currentUser!.uid);

                            ref.read(userProvider.state).update((user) {
                              user = AuthUser.fromMap(currentUser!);
                              return user;
                            });
                          });
                        } on FirebaseAuthException catch (error) {
                          showSnackBar(context, error.toString());
                          throw error;
                        }
                      }),
                  // CustomRichText(
                  //   description: 'Already Have an account? ',
                  //   text: 'Log In here',
                  //   onTap: () {
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: (context) => const SignIn()));
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
