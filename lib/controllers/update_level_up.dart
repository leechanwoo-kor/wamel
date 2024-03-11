import 'package:flame/components.dart';

import '../components/ball.dart';
import '../game/game_life.dart';
import '../game/game_state.dart';
import '../game/level/levels.dart';
import '../game/my_game.dart';
import '../particles/bloom_particle.dart';
import '../tools/audio_tool.dart';

class UpdateLevelUp extends Component with HasGameRef<MyGame> {
  @override
  void update(double dt) {
    if (gameRef.hide) return;
    if (GameState.gameStatus != GameStatus.start) return;

    // Ball 컴포넌트 제거
    gameRef.children
        .whereType<Ball>()
        .where((ball) => ball.isRemoved)
        .toList()
        .forEach((ball) {
      ball.removeFromParent();
    });

    // Ball 레벨 업 처리
    gameRef.children
        .whereType<Ball>()
        .where((ball) => ball.levelUp)
        .toList()
        .forEach((ball) {
      final isLastLevel = Levels.isLastLevel(ball.level + 1);
      ball.removeFromParent();
      AudioTool.mix();
      GameState.updateScore(GameState.score + ball.level);
      final radius = Levels.radius(ball.level + 1);

      // 새 Ball 추가
      gameRef.add(Ball.create(
        position: ball.position.clone()..y += (radius - ball.radius),
        level: ball.level + 1,
        canFall: true,
        landed: true,
        bounce: true,
        gameRef: gameRef,
        moving: true,
      ) as Component);

      // BloomParticle 표시
      BloomParticle(gameRef).show(ball.position, radius);

      if (isLastLevel) {
        GameLife(gameRef).win();
      }
    });
  }
}
