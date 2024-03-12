import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:wamel/game/my_game.dart';

import '../tools/size_tool.dart';

class Scores extends TextComponent {
  static double margin = 5;

  static Scores create(
    MyGame game, {
    String? text,
    Color? color,
    double? size,
  }) {
    color ??= Colors.orange;
    size ??= game.vw(10);
    return Scores(
        text: text ?? '',
        textRenderer: TextPaint(
          style: TextStyle(
            color: color,
            fontSize: size,
          ),
        ),
        position: Vector2(game.vw(margin), game.vw(margin)));
  }

  Scores({
    super.text,
    required TextPaint super.textRenderer,
    required Vector2 super.position,
  });
}
