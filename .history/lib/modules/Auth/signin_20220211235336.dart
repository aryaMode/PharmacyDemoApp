import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/models/tab_titles.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/providers/auth_providers.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_button.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_page_template.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_form_field.dart';
import 'package:demo_catalog_app/utils/ui/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  bool _obscureText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: SingleChildScrollView(
                  child: AuthPageTemplate(
                    child: Column(
                      children: [
                        CustomFormField(
                          hintText: "Email",
                          obsecureText: false,
                          controller: _emailController,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomFormField(
                          hintText: "Password",
                          obsecureText: _obscureText,
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: _obscureText
                                    ? Colors.grey
                                    : kSecondaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              }),
                          controller: _passwordController,
                        ),
                        AuthButton(
                          onTap: () async {
                            try {
                              setState(() {
                                isLoading = !isLoading;
                              });
                              await AuthServices()
                                  .authSignin(
                                      context: context,
                                      email: email,
                                      password: password)
                                  .then((_) async {
                                await Locations.updateLocationsFromFirebase();
                                await TabTitles.updateTabTitlesFromFirebase();

                                var currentUser =
                                    await AuthServices().getCurrentUserInfo(
                                  uid: AuthServices.auth.currentUser!.uid,
                                );
                                ref.read(userProvider.state).state =
                                    AuthUser.fromMap(currentUser!);
                                if (!kIsWeb) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setStringList(
                                      "locations", Locations.locations);
                                  await prefs.setStringList(
                                      "tabTitles", TabTitles.tabTitles);
                                  await prefs.setBool(
                                      "admin", currentUser["admin"]);
                                  await prefs.setString(
                                      "location", currentUser["location"]);
                                  await prefs.setString(
                                      "uid", currentUser["uid"]);
                                }
                                setState(() {
                                  isLoading = !isLoading;
                                });
                                if(kIsWeb && !ref.read(userProvider).admin){
                                  showSnackBar(context, "Only admins can access Admin Panel :(");
                                }
                                context.router.replace(IntroductionPageRoute());
                              });
                            } on FirebaseAuthException catch (error) {
                              setState(() {
                                isLoading = !isLoading;
                              });
                              showSnackBar(context, error.toString());
                            }
                          },
                          text: 'Sign In',
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
