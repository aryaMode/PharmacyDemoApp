import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:demo_catalog_app/modules/Auth/provider.dart';
import 'package:demo_catalog_app/modules/Auth/signin.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_button.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/auth_page_template.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_form_field.dart';
import 'package:demo_catalog_app/modules/Auth/widgets/custom_rich_text.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AuthPageTemplate(
          child: SignUpWidget(),
        ),
      ),
    );
  }
}



class SignUpWidget extends ConsumerStatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends ConsumerState<SignUpWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get location => dropDownValue;
  bool get role => isAdmin;
  String dropDownValue = "Gujarat";
  bool _obscureText = true;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return 
  }
}
