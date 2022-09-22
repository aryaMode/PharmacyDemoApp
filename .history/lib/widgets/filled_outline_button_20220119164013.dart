import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'text_widget.dart';

class FillOutlineButton extends StatelessWidget {
  final VoidCallback? press;
  final void Function(String)? onFieldSubmitted;
  final String text;
  final Color? textColor, backgroundColor;
  final Color borderColor;

  const FillOutlineButton({
    Key? key,
    this.press,
    required this.text,
    this.onFieldSubmitted,
    this.editable,
    this.textColor = Colors.black,
    this.backgroundColor = kPrimaryColor,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 15,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          side: BorderSide(
            color: borderColor,
          )),
      elevation: 2,
      color: backgroundColor,
      onPressed: press,
      child: TextWidget(
        onFieldSubmitted: onFieldSubmitted,
        text: text,
        textStyle: TextStyle(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }

  FillOutlineButton copyWith({
    VoidCallback? press,
    String? text,
  }) {
    return FillOutlineButton(
        press: press ?? this.press,
        text: text ?? this.text,
        onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted);
  }
}
