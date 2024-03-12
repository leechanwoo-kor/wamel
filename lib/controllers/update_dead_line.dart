import 'package:flame/components.dart';

import '../components/ball.dart';
import '../components/dead_line.dart';
import '../game/game_state.dart';
import '../game/my_game.dart';
import '../tools/size_tool.dart';

class UpdateDeadLine extends Component with HasGameRef<MyGame> {
  @override
  void update(double dt) {
    if (gameRef.hide) return;
    if (GameState.gameStatus != GameStatus.start) return;
    final almostDeads = gameRef.children.where((e) =>
        e is Ball && e.landed && e.position.y < gameRef.vw(DeadLine.showTop));
    if (almostDeads.isNotEmpty) {
      DeadLine.show = true;
    } else {
      DeadLine.show = false;
    }
    if (gameRef.children.any((e) =>
        e is Ball &&
        e.landed &&
        e.position.y < gameRef.vw(DeadLine.marginTop))) {
      // GameLife(gameRef).dead();
    }
  }
}
