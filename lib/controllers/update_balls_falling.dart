import 'package:flame/components.dart';

import '../components/ball.dart';
import '../game/game_state.dart';
import '../game/my_game.dart';
import '../tools/size_tool.dart';

class UpdateBallsFalling extends Component with HasGameRef<MyGame> {
  @override
  void update(double dt) {
    if (gameRef.hide || GameState.gameStatus != GameStatus.start) return;

    gameRef.children
        .whereType<Ball>()
        .where((ball) => !ball.isFalling)
        .forEach(updateBallState);
  }

  void updateBallState(Ball ball) {
    if (!ball.moving) return;

    final p = ball.position;
    final fp = ball.fallPosition;
    final width = gameRef.vw(100);
    final isLeft = fp.x < gameRef.center.x / 2;
    final isCenter = (fp.x - gameRef.center.x).abs() < gameRef.vw(5);

    adjustBallVelocity(ball, isLeft, isCenter);

    if (shouldRemoveBall(ball, p, fp, width, isLeft, isCenter)) {
      gameRef.remove(ball);
      gameRef.add(createNewBall(ball, p));
    }
  }

  void adjustBallVelocity(Ball ball, bool isLeft, bool isCenter) {
    if (!isCenter && ball.body.linearVelocity.x == 0) {
      ball.body.linearVelocity =
          Vector2((isLeft ? -1 : 1) * gameRef.size.velocitySize * 10, 0);
    }
  }

  bool shouldRemoveBall(Ball ball, Vector2 p, Vector2 fp, double width,
      bool isLeft, bool isCenter) {
    return isCenter ||
        (isLeft && (p.x < ball.radius || p.x < fp.x)) ||
        (!isLeft && (width - p.x < ball.radius || p.x > fp.x));
  }

  Ball createNewBall(Ball oldBall, Vector2 position) {
    return Ball.create(
      position: position,
      level: oldBall.level,
      canFall: true,
      gameRef: gameRef,
      moving: true,
      bounce: false,
      landed: false,
    );
  }
}
