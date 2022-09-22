
import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/widgets/text_widget.dart';
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