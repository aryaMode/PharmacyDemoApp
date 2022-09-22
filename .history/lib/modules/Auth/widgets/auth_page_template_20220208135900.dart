import 'package:demo_catalog_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AuthPageTemplate extends StatelessWidget {
  final Widget child;
  const AuthPageTemplate({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: kSecondaryColor,
        ),
        Align(
          child: Container(
            height: getScreenHei ght(context) * 0.9,
            width: getScreenWidth(context) * 0.95,
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
                child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}