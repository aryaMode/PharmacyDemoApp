import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setOrientationLandscape(Color color) {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void setOrientationPortrait() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setEnabledSystemUIMode();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
