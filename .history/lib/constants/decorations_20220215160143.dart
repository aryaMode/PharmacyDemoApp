import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

import 'colors.dart';


const BoxDecoration kSplashScreenDecoration = BoxDecoration(
  color: kPrimaryColor,
);

const InputBorder kSearchBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black),
  borderRadius:
      const BorderRadius.all(Radius.circular(kDefaultBorderRadius / 2)),
);

const InputDecoration searchFieldInputDecoration = InputDecoration(
  filled: false,
  labelText: 'Search',
  border: kSearchBorder,
  fillColor: kSecondaryColor,
  focusedBorder: kSearchBorder,
  contentPadding: EdgeInsets.all(kDefaultPadding / 2),
  labelStyle: TextStyle(color: Colors.black),
);
