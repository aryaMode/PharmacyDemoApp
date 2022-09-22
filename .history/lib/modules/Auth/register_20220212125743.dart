import 'package:auto_route/auto_route.dart';
import 'package:demo_catalog_app/config/routes/routes.gr.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_button.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_page_template.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_form_field.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/utils/ui/showSnackBar.dart';
import 'package:demo_catalog_app/widgets/drop_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Register extends ConsumerStatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get location => dropDownValue;

  bool _obscureText = true;
  bool isAdmin = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
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
                          textInputType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomFormField(
                          controller: _passwordController,
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
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        Container(
                          width: getScreenWidth(context) * 0.56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: (!isAdmin
                                    ? <Widget>[
                                        Flexible(
                                          child: Container(
                                            width:
                                                getScreenWidth(context) * 0.25,
                                            child: DropDown(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          kDefaultPadding * 2),
                                              items: Locations.locations,
                                              value: Locations.locations[
                                                  ref.watch(
                                                      locationIndexProvider)],
                                              onChanged: (changedValue) {
                                                ref
                                                        .read(
                                                            locationIndexProvider
                                                                .state)
                                                        .state =
                                                    (Locations.locations
                                                        .indexOf(
                                                            changedValue!));
                                              },
                                            ),
                                          ),
                                        ),
                                      ]
                                    : <Widget>[]) +
                                <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      child: Column(
                                        children: [
                                          Checkbox(
                                            value: isAdmin,
                                            onChanged: (bool? value) {
                                              setState(
                                                () {
                                                  isAdmin = value!;
                                                  if (isAdmin) {
                                                    dropDownValue =
                                                        Locations.locations[0];
                                                  }
                                                },
                                              );
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
                                    ),
                                  )
                                ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AuthButton(
                          text: 'Register',
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await AuthServices.register(
                                email: email,
                                password: password,
                                context: context,
                                location: location,
                                admin: isAdmin,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              context.router.replace(DashboardRoute());
                            } on FirebaseAuthException catch (error) {
                              showSnackBar(context, error.toString());
                              throw error;
                            }
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
