import 'dart:math';

import 'package:flutter/material.dart';

class ScreenTool {
  factory ScreenTool() => _instance;
  ScreenTool._()
      : allowFontScaling = false,
        uiSize = const Size(0, 0);
  static final ScreenTool _instance = ScreenTool._();

  static const Size defaultSize = Size(360, 640);

  Size uiSize;

  bool allowFontScaling;

  double _pixelRatio = 1;
  double _textScaleFactor = 1;
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _statusBarHeight = 0;
  double _bottomBarHeight = 0;

  void init(
    BoxConstraints constraints, {
    required Size designSize,
    required bool allowFontScaling,
  }) {
    uiSize = designSize;
    this.allowFontScaling = allowFontScaling;

    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    var window = WidgetsBinding.instance.window;

    _pixelRatio = window.devicePixelRatio;
    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;
    _textScaleFactor = window.textScaleFactor;
  }

  double width(num width) => width * scaleWidth;

  double height(num height) => height * scaleHeight;

  double radius(num r) => r * scaleText;

  double font(num fontSize, {required bool allowScaling}) =>
      allowScaling == null
          ? (allowFontScaling
              ? (fontSize * scaleText) * _textScaleFactor
              : (fontSize * scaleText))
          : (allowScaling
              ? (fontSize * scaleText) * _textScaleFactor
              : (fontSize * scaleText));

  double get textScaleFactor => _textScaleFactor;

  double get pixelRatio => _pixelRatio;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get screenMin => min(_screenWidth, _screenHeight);

  double get screenMax => max(_screenWidth, _screenHeight);

  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);
}
