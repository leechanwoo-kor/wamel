import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';

import '../controllers/generate_ball.dart';
import '../tools/size_tool.dart';
import 'game_onload.dart';

final screenSize = Vector2(720, 1080);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);

class MyGame extends Forge2DGame {
  MyGame({
    required this.hide,
  }) : super(
          world: MyWorld(),
          gravity: Vector2(0, 20.0),
        );

  bool hide;
}

// class MyWorld extends Forge2DWorld with TapCallbacks, MultiTouchDragDetector {
class MyWorld extends Forge2DWorld with TapCallbacks, HasGameReference<MyGame> {
  PositionComponent camera = PositionComponent();

  @override
  Future<void> onLoad() async {
    game.camera.viewfinder.visibleGameSize = worldSize;
    game.camera.viewfinder.anchor = Anchor.topCenter;
    super.onLoad();
    game.camera.viewport.add(FpsTextComponent());

    await GameOnload(game).onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.hide) return;
    super.onTapDown(event);
    print(
        "game.camera.viewfinder.visibleGameSize:  ${game.camera.viewfinder.visibleGameSize}");
    print("game.camera.viewport.size.x:  ${game.camera.viewport.size.x}");
    print("game.camera.viewport.size.y:  ${game.camera.viewport.size.y}");
    print("game.size.x:  ${game.size.x}");
    print("game.size.y:  ${game.size.y}");
    print("game.vw(30):  ${game.vw(30)}");
    print("game.vh(30):  ${game.vh(30)}");
    print("event.localPosition.x:  ${event.localPosition.x}");
    print("event.localPosition.y:  ${event.localPosition.y}");
    if (event.localPosition.y > game.vh(30) / 100) {
      GenerateBall(game).generateBall(event.localPosition.x);
    }
  }

  @override
  void update(double dt) {
    if (game.hide) return;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (game.hide) return;
    super.render(canvas);
  }
}
