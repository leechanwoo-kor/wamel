import 'package:flame/components.dart';

import '../components/boundaries.dart';
import '../contacts/ball_ball_contact.dart';
import '../contacts/ball_wall_contact.dart';
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
    final boundaries = createBoundaries(gameRef.size);
    boundaries.forEach(gameRef.add);
    //初始化碰撞检测器
    gameRef.addContactCallback(BallWallContactCallback());
    gameRef.addContactCallback(BallBallContactCallback());
  }
}
