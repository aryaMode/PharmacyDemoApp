import 'package:flutter/material.dart';

import 'colors.dart';

const kSlideshowTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600);

const kProductButtonTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  letterSpacing: 0.5,
  fontSize: 15,
  overflow: TextOverflow.clip,
);


const TextStyle kButtonTextStyle = TextStyle(
  color: kPrimaryColor,
);

//TODO: Change font according to Company
const kProductNameTextStyle = TextStyle(
    letterSpacing: 2,
    height: 1.1,
    color: Colors.black,
    fontFamily: 'PrimaryFont',
    fontSize: 47,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600);

const kTaglineAndTextSizeStyle = TextStyle(
  fontSize: 18,
  fontFamily: 'PrimaryFont',
);
const kDashboardTextStyle = TextStyle(
    letterSpacing: 2,
    color: Colors.white,
    fontFamily: 'PrimaryFont',
    fontStyle: FontStyle.normal,
    fontSize: 42,
    fontWeight: FontWeight.w600);

const kAppBarTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'PrimaryFont',
  fontWeight: FontWeight.w200,
);