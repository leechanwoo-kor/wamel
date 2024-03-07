import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemTool {
  // TODO static void changeStatusBarColor([Color color]) {
  static void changeStatusBarColor([Color color = Colors.white]) {
    color ??= Colors.white;
    final style = SystemUiOverlayStyle(
      statusBarColor: color,
      systemNavigationBarDividerColor: null,
      systemNavigationBarColor: color,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  static void keepPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
