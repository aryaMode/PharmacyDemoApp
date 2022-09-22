import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setOrientationLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void setOrientationPortrait(Color color) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
