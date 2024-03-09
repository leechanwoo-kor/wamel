import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import '../components/ball.dart';
import '../game/game_state.dart';
import '../game/level/levels.dart';
import '../game/my_game.dart';
import '../tools/size_tool.dart';

class GenerateBall {
  MyGame gameRef;
  GenerateBall(this.gameRef);

  bool get canGenerateBall => gameRef.children
      .whereType<Ball>()
      .where((e) => e.moving && !e.landed)
      .isEmpty;

  /// 생성할 수 있는지 확인 후 새로운 볼 생성
  Future<void> generateBall([double x = 0]) async {
    if (gameRef.hide) return;
    if (!canGenerateBall) return;
    if (GameState.gameStatus != GameStatus.start) return;
    if (GameState.lastBall != null) {
      GameState.lastBall?.fallPosition.x = x;
      GameState.lastBall?.moving = true;
    }
    final level = await Levels.generateLevel();
    final position = Vector2(x,
        gameRef.size.y * (Levels.radius(level) + 5) / 100); // 화면 크기에 따른 비율 조정
    final ball = Ball.create(
      position: position,
      level: level,
      moving: false,
      bounce: true,
      gameRef: gameRef,
    );
    gameRef.add(
        ball as Component); // Forge2D의 BodyComponent를 상속받는 Ball 인스턴스를 직접 추가
    GameState.lastBall = ball as Ball;

    // Forge2D에서는 업데이트 로직이 다를 수 있으므로, 필요에 따라 Ball 클래스를 수정해야 할 수 있습니다.
  }
}
