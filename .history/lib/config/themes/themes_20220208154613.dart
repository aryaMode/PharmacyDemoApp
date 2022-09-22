import 'package:demo_catalog_app/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.black),
  fontFamily: 'PrimaryFont',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: kPrimaryColor,
).useMaterial3;
