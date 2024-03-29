import 'package:flame/components.dart';

import '../components/ball.dart';
import '../game/my_game.dart';

class UpdateBallsBounce extends Component with HasGameRef<MyGame> {
  @override
  void update(double dt) {
    if (gameRef.hide) return;
    // if (GameState.gameStatus != GameStatus.start) return;
    gameRef.children.where((e) => e is Ball && e.bouncing).forEach((ball) {
      Ball b = ball as Ball;
      // final realSize = b.radius * 2 / gameRef.viewport.scale;
      final realSize = b.radius * 2 / 100;
      if (b.size.x < realSize) {
        var size = b.size.x + dt * 10 * realSize;
        size = size.clamp(b.size.x, realSize);
        b.size = Vector2(size, size);
      } else {
        b.bouncing = false;
        if (!b.isFalling) return;
        gameRef.remove(ball);
        gameRef.add(Ball.create(
          gameRef: gameRef,
          position: b.position,
          level: b.level,
          canFall: true,
          landed: true,
          moving: true,
          bounce: false,
        ) as Component);
      }
    });
  }
}
