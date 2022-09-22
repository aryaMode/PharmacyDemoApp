import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:flutter/material.dart';

class AuthPageTemplate extends StatelessWidget {
  final Widget child;
  const AuthPageTemplate({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Stack(
        // children: [
        // Container(
        //   height: getScreenHeight(context),
        //   width: getScreenWidth(context),
        //   color: kSecondaryColor,
        // ),
        Container(
      // height: getScreenHeight(context),
      // width: getScreenWidth(context),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              // height: getScreenHeight(context) * 0.25,
              // width: getScreenWidth(context) * 0.8,
              child: Image.asset(kCompanyLogo),
            ),
            SizedBox(
              height: 16,
            ),
            child,
          ],
        ),
      ),
      // ),
      // ],
    );
  }
}
