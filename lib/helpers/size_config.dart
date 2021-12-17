import 'package:flutter/material.dart';

class SizeConfig {
  late double _textMultiplier;
  late double _heightMultiplier;
  late double _widthMultiplier;

  late double _designWidth;
  late double _designHeight;

  static final SizeConfig _instance = SizeConfig._internal();

  factory SizeConfig() {
    return _instance;
  }

  SizeConfig designWidth(double width) {
    _designWidth = width / 100;
    return this;
  }

  SizeConfig designHeight(double height) {
    _designHeight = height / 100;
    return this;
  }

  SizeConfig._internal();

  void init(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;

    var blockWidth = screenWidth / 100;
    var blockHeight = screenHeight / 100;

    _textMultiplier = blockHeight;
    _heightMultiplier = blockHeight;
    _widthMultiplier = blockWidth;
  }

  double scaleTextFont(double fontSize) {
    double scale = fontSize / _designHeight;
    return (_textMultiplier * scale);
  }

  double scaleWidth(double width) {
    double scale = width / _designWidth;
    return (_widthMultiplier * scale);
  }

  double scaleHeight(double height) {
    //scale = 20 / 8.12 = 2.4630541871921
    //7.4 * scale

    double scale = height / _designHeight;
    return (_heightMultiplier * scale);
  }
}
