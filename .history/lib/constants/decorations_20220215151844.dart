import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

// const kMessageTextFieldDecoration = InputDecoration(
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   hintText: 'Type your message here...',
//   border: InputBorder.none,
// );

// const kTextFieldDecoration = InputDecoration(
//   hintText: 'Enter a value',
//   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// );

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
