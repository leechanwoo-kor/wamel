import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';

import '../controllers/generate_ball.dart';
import '../tools/size_tool.dart';
import 'game_onload.dart';

class MyGame extends Forge2DGame with TapCallbacks, MultiTouchDragDetector {
  MyGame({
    required this.hide,
  }) : super(gravity: Vector2(0, 100), zoom: 10);

  bool hide;

  Vector2 get center => Vector2(size.x / 2, size.y / 2);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewport.add(FpsTextComponent());
    await GameOnload(this).onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (hide) return;
    // super.onTapDown(event);
    if (event.localPosition.y > vw(30)) {
      GenerateBall(this).generateBall(event.localPosition.x);
    }
  }

  @override
  void update(double dt) {
    if (hide) return;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (hide) return;
    super.render(canvas);
  }
}
