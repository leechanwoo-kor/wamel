import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/forge2d.dart';

List<Wall> createBoundaries(Vector2 screenSize) {
  final topRight = screenSize / 2;
  final bottomLeft = -topRight;
  final topLeft = Vector2(bottomLeft.x, topRight.y);
  final bottomRight = Vector2(topRight.x, bottomLeft.y);

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
  final int id;

  Wall(this.start, this.end, this.id);

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(start, end);

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
