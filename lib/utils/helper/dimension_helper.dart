import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

Size getScreenSize(BuildContext context) => MediaQuery.of(context).size;
double getScreenWidth(BuildContext context) => getScreenSize(context).width;
double getScreenHeight(BuildContext context) => getScreenSize(context).height;
double getAspectRatio(BuildContext context,
        {double aspectRatio = kDefaultAspectRation}) =>
    getScreenWidth(context) / (getScreenHeight(context) / aspectRatio);
