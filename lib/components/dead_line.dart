import 'package:flame/components.dart';
import 'package:wamel/game/my_game.dart';

import '../tools/image/image_tool.dart';
import '../tools/size_tool.dart';

class DeadLine extends SpriteComponent {
  static double marginTop = 36;

  static double showTop = marginTop + 44;

  static bool show = false;

  static DeadLine create(MyGame gameRef) {
    final sprite = Sprite(ImageTool.image('dead_line.png'));
    return DeadLine(
        sprite: sprite,
        size: Vector2(
          gameRef.size.x,
          gameRef.vw(1),
        ),
        position: Vector2(0, gameRef.vw(marginTop)));
  }

  DeadLine({super.sprite, super.size, super.position});

  @override
  void render(canvas) {
    // if (!show) return;
    super.render(canvas);
  }
}
