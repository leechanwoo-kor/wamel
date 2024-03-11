import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:wamel/game/my_game.dart';

extension Size2Vector on Size {
  Vector2 get toVector => Vector2(width, height);
}

extension Offset2Vector on Offset {
  Vector2 get toVector => Vector2(dx, dy);
}

extension Vector2Offset on Vector2 {
  Offset get toOffset => Offset(x, y);
  double get gravitySize => y / 600 * 50;
  double get velocitySize => x / 6;
}

extension SizeVector on BuildContext {
  Size get size => MediaQuery.of(this).size;
  Vector2 get vector => Vector2(size.width, size.height);
}

// Since `Viewport` is not directly a part of `flame_forge2d` as of my last update,
// you might be using a custom or extended functionality.
// Ensure you have a compatible `Viewport` class or interface to work with this extension.
// If you are working with a camera or viewport within Flame,
// adjust this extension to match the actual API you're interfacing with.

// extension VW on v.Viewport {
//   double vw(double percent) => percent * (size.x / 100);
//   double vh(double percent) => percent * (size.y / 100);
// }

extension GameSizeExtensions on MyGame {
  double vw(double percentage) => camera.viewport.size.x * (percentage / 100);
  double vh(double percentage) => camera.viewport.size.y * (percentage / 100);
}
