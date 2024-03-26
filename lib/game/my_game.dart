import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import '../controllers/generate_ball.dart';
import '../tools/size_tool.dart';
import 'game_onload.dart';

final screenSize = Vector2(720, 1280);
const cameraZoom = 100.0;
final worldSize = Vector2(screenSize.x / cameraZoom, screenSize.y / cameraZoom);

class MyGame extends Forge2DGame with HasGameRef<Forge2DGame> {
  bool hide;

  MyGame({
    required this.hide,
  }) : super(
          world: MyWorld(),
          // zoom: cameraZoom,
          gravity: Vector2(0, 20.0),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.viewport = FixedResolutionViewport(resolution: screenSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    camera.viewfinder.zoom += 0.1;
  }

  @override
  void onMount() {
    super.onMount();
    debugMode = true;
  }

  // @override
  // void onGameResize(Vector2 size) {
  //   super.onGameResize(size);
  // }

  @override
  Color backgroundColor() {
    // Paints the background red
    return Colors.red;
  }
}

// class MyWorld extends Forge2DWorld with TapCallbacks, MultiTouchDragDetector {
class MyWorld extends Forge2DWorld with TapCallbacks, HasGameReference<MyGame> {
  PositionComponent camera = PositionComponent();

  @override
  Future<void> onLoad() async {
    game.camera.viewfinder.visibleGameSize = worldSize;
    game.camera.viewfinder.anchor = Anchor.topLeft;
    super.onLoad();
    game.camera.viewport.add(FpsTextComponent());

    await GameOnload(game).onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.hide) return;
    super.onTapDown(event);
    if (event.localPosition.y > game.vh(20) / game.camera.viewfinder.zoom) {
      GenerateBall(game)
          .generateBall(event.localPosition.x * game.camera.viewfinder.zoom);
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
