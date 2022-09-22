import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextEditingController controller;

  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.obsecureText,
    this.textInputType = TextInputType.text,
    this.suffixIcon = const SizedBox.shrink(),
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: getScreenHeight(context) * 0.15,
          width: getScreenWidth(context) * 0.56,
          margin: const EdgeInsets.symmetric(horizontal: 150),
          decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              maxLines: 1,
              controller: controller,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
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
