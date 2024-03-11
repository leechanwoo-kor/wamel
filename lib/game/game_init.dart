import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';

import '../components/boundaries.dart';
import '../tools/size_tool.dart';
import 'my_game.dart';

class GameInit {
  MyGame gameRef;
  GameInit(this.gameRef);

  void init(Vector2 size) {
    final scale = 10.0;
    final gravity = Vector2(0, -1) * size.gravitySize;
    gameRef.world.gravity = gravity;
    // gameRef.viewport = Viewport(size, scale);
    gameRef.camera.viewport = FixedResolutionViewport(resolution: size);

    final boundaries = createBoundaries(gameRef);
    boundaries.forEach(gameRef.add);
  }
}
