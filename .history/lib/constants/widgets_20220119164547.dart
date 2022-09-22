import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/widgets/filled_outline_button.dart';
import 'package:flutter/material.dart';

Widget buildAddButton({
  void Function()? onAddPress,
}) =>
    FillOutlineButton(
      editable: ,
      backgroundColor: kSecondaryColor,
      textColor: Colors.white,
      press: onAddPress,
      text: "+",
    );
