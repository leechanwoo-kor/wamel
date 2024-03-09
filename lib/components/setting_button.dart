import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:wamel/game/game_life.dart';
import 'package:wamel/game/my_game.dart';

import '../tools/size_tool.dart';

class SettingButton extends SpriteComponent
    with TapCallbacks, HasGameRef<MyGame> {
  static double margin = 5;

  SettingButton({Sprite? sprite, Vector2? size, Vector2? position})
      : super(sprite: sprite, size: size, position: position);

  @override
  bool onTapDown(TapDownEvent event) {
    GameLife(gameRef).setting();
    return true;
  }

  static Future<SettingButton> create(MyGame gameRef) async {
    final sprite = await Sprite.load('setting.png');
    return SettingButton(
      sprite: sprite,
      size: Vector2(gameRef.vw(10), gameRef.vw(10)),
      position: Vector2(gameRef.vw(100 - margin - 10), gameRef.vw(margin)),
    );
  }
}
