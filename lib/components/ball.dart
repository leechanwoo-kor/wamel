import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:wamel/components/boundaries.dart';
import 'package:wamel/game/game_state.dart';
import 'package:wamel/game/level/levels.dart';
import 'package:wamel/game/my_game.dart';
import 'package:wamel/tools/audio_tool.dart';

class Ball extends BodyComponent<MyGame> with ContactCallbacks {
  MyGame gameRef;
  final Vector2 fallPosition;
  final bool isFalling;
  final int level;
  final double radius;
  bool landed;
  bool levelUp = false;
  bool removing = false;
  bool moving;
  bool bouncing;
  late SpriteComponent spriteComponent;

  Vector2 get size => spriteComponent.size;

  set size(Vector2 newSize) {
    spriteComponent.size = newSize;
  }

  static Ball create({
    required MyGame gameRef,
    required Vector2 position,
    required int level,
    required bool moving,
    required bool canFall,
    required bool landed,
    required bool bounce,
  }) {
    return Ball(
      gameRef: gameRef,
      level: level,
      fallPosition: position,
      isFalling: canFall,
      landed: landed,
      moving: moving,
      bouncing: bounce,
      sprite: Levels.sprite(level),
      radius: Levels.radius(level) * (gameRef.camera.viewport.size.x / 100),
    );
  }

  Ball({
    required this.gameRef,
    required this.fallPosition,
    required this.isFalling,
    required this.level,
    required this.radius,
    this.landed = false,
    this.moving = true,
    this.bouncing = true,
    Sprite? sprite,
  }) {
    spriteComponent =
        SpriteComponent(sprite: sprite, size: Vector2.all(radius * 2));
  }

  @override
  Body createBody() {
    // final shape = CircleShape()..radius = size.x / 2;
    final shape = CircleShape()..radius = radius;

    var position = fallPosition.clone();
    if (!isFalling) {
      position.x = gameRef.camera.viewport.size.x / 2;
      position.x = gameRef.size.x / 2;
    }

    final bodyDef = BodyDef(
      position: position,
      userData: this,
      angularDamping: 0.1,
      type: isFalling ? BodyType.dynamic : BodyType.kinematic,
    );

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.1
      ..density = 0.1
      ..friction = 0.1;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Wall) {
      if (GameState.gameStatus != GameStatus.start) return;
      if (other.side != 3) return;
      if (!landed) {
        AudioTool.fall();
      }
      landed = true;
    }
    if (other is Ball) {
      if (GameState.gameStatus != GameStatus.start) return;
      landed = true;
      other.landed = true;
      if (level == other.level) {
        if (position.y < other.position.y) {
          removing = true;
          other.levelUp = true;
        } else {
          other.removing = true;
          levelUp = true;
        }
      }
    }
  }
}
