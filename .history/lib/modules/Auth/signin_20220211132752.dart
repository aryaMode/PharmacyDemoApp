import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/provider.dart';
import 'package:demo_catalog_app/modules/Auth/signup.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_button.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_page_template.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_form_field.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_rich_text.dart';
import 'package:demo_catalog_app/utils/ui/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      body: ProgressHUD(
        child: SafeArea(
          child: 
          
          Center(
            child: SingleChildScrollView(
              child: AuthPageTemplate(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            color: _obscureText ? Colors.grey : kSecondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          }),
                      controller: _passwordController,
                    ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    AuthButton(
                      onTap: () async {
  final progress = ProgressHUD.of(context);
                        progress?.show();                        try {
                          await AuthServices()
                              .authSignin(
                                  context: context,
                                  email: email,
                                  password: password)
                              .then((_) async {
                            var currentUser = await AuthServices()
                                .getCurrentUserInfo(
                                    uid: AuthServices.auth.currentUser!.uid);
                            ref.read(userProvider.state).update((user) {
                              user = AuthUser.fromMap(currentUser!);
                              return user;
                            });
                            context.router.replace(IntroductionPageRoute());
      
                            print(ref.read(userProvider.state).state);
                          progress. 
                          });
                        } on FirebaseAuthException catch (error) {
                          showSnackBar(context, error.toString());
                        }
                      },
                      text: 'Sign In',
                    ),
                    // SizedBox(
                    //   height: 16,
                    // )
                    // CustomRichText(
                    //   description: "Don't already Have an account? ",
                    //   text: "Sign Up",
                    //   onTap: () {
                    //     Navigator.pushReplacement(context,
                    //         MaterialPageRoute(builder: (context) => const SignUp()));
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
