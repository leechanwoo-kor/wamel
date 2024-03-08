import 'package:flame/components.dart';
import 'package:wamel/game/my_game.dart';

import '../game/level/levels.dart';
import '../tools/image/image_tool.dart';

class Background extends SpriteComponent {
  Background.create(MyGame game) {
    resize(game);
    sprite = Sprite(ImageTool.image(Levels.background));
  }

  void resize(MyGame game) {
    width = game.size.x;
    height = game.size.y;
  }
}
