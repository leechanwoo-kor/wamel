import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' hide Image, Gradient;

enum GameColors {
  green,
  blue,
  red,
  yellow,
  purple,
  black,
  white,
  grey,
  orange,
}

extension GameColorExtension on GameColors {
  Color get color {
    switch (this) {
      case GameColors.green:
        return ColorExtension.fromRGBHexString('#14F596');
      case GameColors.blue:
        return ColorExtension.fromRGBHexString('#81DDF9');
      case GameColors.red:
        return ColorExtension.fromRGBHexString('#FF0000');
      case GameColors.yellow:
        return ColorExtension.fromRGBHexString('#FFFF00');
      case GameColors.purple:
        return ColorExtension.fromRGBHexString('#6A0DAD');
      case GameColors.black:
        return ColorExtension.fromRGBHexString('#000000');
      case GameColors.white:
        return ColorExtension.fromRGBHexString('#FFFFFF');
      case GameColors.grey:
        return ColorExtension.fromRGBHexString('#808080');
      case GameColors.orange:
        return ColorExtension.fromRGBHexString('#FFA500');
    }
  }

  Paint get paint => Paint()..color = color;
}
