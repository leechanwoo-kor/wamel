import 'package:flame/components.dart';
import 'package:wamel/game/my_game.dart';

import '../tools/image/image_tool.dart';
import '../tools/size_tool.dart';

class DeadLine extends SpriteComponent {
  static double marginTop = 36;
  static double showTop = marginTop + 44;

  static bool show = false;

  DeadLine({Sprite? sprite, Vector2? size, Vector2? position})
      : super(sprite: sprite, size: size, position: position);

  static Future<DeadLine> create(MyGame game) async {
    final sprite = Sprite(ImageTool.image('dead_line.png'));
    return DeadLine(
        sprite: sprite,
        size: Vector2(
          game.size.x,
          game.vw(1),
        ),
        position: Vector2(0, game.vw(marginTop)));
  }

  @override
  void render(canvas) {
    if (!show) return;
    super.render(canvas);
  }
}
