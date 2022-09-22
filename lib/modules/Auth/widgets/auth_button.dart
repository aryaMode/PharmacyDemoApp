import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:flutter/material.dart';

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
        width: getScreenWidth(context) * 0.122,
        // height: getScreenHeight(context) * 0.05,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: AutoSizeText(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
