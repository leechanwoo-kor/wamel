import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Scores extends TextComponent with HasGameRef {
  static final double margin = 5.0;

  Scores({
    required String text,
    required Vector2 position,
    double? textSize,
    Color? color,
  }) : super(
          text: text,
          position: position,
          textRenderer: TextPaint(
            style: TextStyle(
              fontSize: textSize,
              color: color ?? Colors.orange,
            ),
          ),
        );

  static Scores create(
    Game game, {
    required String text,
    Color? color,
    double? size,
  }) {
    final gameSize = game.size;
    final textSize = size ?? gameSize[0] * 0.1; // 예: 뷰포트 너비의 10%로 설정
    final position = Vector2(margin, gameSize[1] - textSize - margin); // 화면 하단에 위치
    return Scores(
      text: text,
      position: position,
      textSize: textSize,
      color: color,
    );
  }
}
