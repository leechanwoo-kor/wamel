import 'package:flutter/material.dart';

import 'screen_tool.dart';

extension SizeExtension on num {
  double get w => ScreenTool().width(this);
  double get h => ScreenTool().height(this);
  double get vw => ScreenTool().screenWidth * this * 0.01;
  double get vh => ScreenTool().screenHeight * this * 0.01;
  double get r => ScreenTool().radius(this);
  double get px => ScreenTool().width(this); //px2dp
  double get sp => ScreenTool().font(this, allowScaling: false);
  double get ssp => ScreenTool().font(this, allowScaling: true);
  double get nsp => ScreenTool().font(this, allowScaling: false);
}

extension ContextExtensionss on BuildContext {
  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  double get shortestSide => mediaQuery.size.shortestSide;
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => theme.brightness == Brightness.dark;
  Color? get iconColor => theme.iconTheme.color;
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  bool get showNavbar => (width > 800);
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  T responsiveValue<T>({
    required T mobile,
    required T tablet,
    required T desktop,
    required T watch,
  }) {
    if (shortestSide >= 1200 && desktop != null) return desktop;
    if (shortestSide >= 600 && tablet != null) return tablet;
    if (shortestSide < 300 && watch != null) return watch;
    return mobile;
  }
}
