import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:wamel/game/my_game.dart';

List<Wall> createBoundaries(MyGame game) {
  // final visibleRect = game.camera.visibleWorldRect;
  // final topRight = visibleRect.topRight.toVector2();
  // final bottomLeft = visibleRect.bottomLeft.toVector2();
  // final topLeft = visibleRect.topLeft.toVector2();
  // final bottomRight = visibleRect.bottomRight.toVector2();
  final bottomRight =
      Vector2(game.camera.viewport.size.x - 5, game.camera.viewport.size.y - 5);
  final bottomLeft = Vector2(5, bottomRight.y);
  final topLeft = Vector2(5, 5);
  final topRight = Vector2(bottomRight.x, 5);
  // final topRight = game.size;
  // final bottomLeft = topRight * -1;
  // final topLeft = Vector2(bottomLeft.x, topRight.y);
  // final bottomRight = topLeft * -1;

  return [
    Wall(topLeft, topRight, 1),
    Wall(topRight, bottomRight, 2),
    Wall(bottomRight, bottomLeft, 3),
    Wall(bottomLeft, topLeft, 4),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final int side;

  Wall(this.start, this.end, this.side);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..userData = this
      ..position = Vector2.zero()
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
