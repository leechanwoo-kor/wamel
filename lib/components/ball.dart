import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import '../game/level/levels.dart';

class Ball extends BodyComponent {
  // 기존 Ball 클래스와 유사한 속성들
  late Vector2 fallPosition;
  bool isFalling;
  int level;
  double _radius;
  bool landed = false;
  bool levelUp = false;
  bool isRemoved = false;
  bool moving = true;
  bool bouncing = false;

  Vector2 get position => body.position;
  double get radius => _radius;

  static Future<Ball> create(
    Forge2DGame game, {
    required Vector2 position,
    required int level,
    bool moving = true,
    bool canFall = false,
    bool landed = false,
    bool bounce = false,
  }) async {
    final sprite = await Levels.sprite(level);
    final radius = Levels.radius(level) * (game.size.x / 100);
    return Ball(
      sprite: sprite,
      radius: radius,
      position: position,
      level: level,
      canFall: canFall,
      landed: landed,
      moving: moving,
      bounce: bounce,
    );
  }

  Ball({
    required Vector2 position,
    required Sprite sprite,
    required double radius,
    required this.level,
    this.landed = false,
    this.moving = true,
    bool canFall = false,
    bool bounce = false,
  }) : _radius = radius, super(sprite: sprite, size: Vector2.all(radius * 2)) {
    fallPosition = position;
    isFalling = canFall;
    bouncing = bounce;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = _radius;
    final fixtureDef = FixtureDef(shape)
      ..restitution = bouncing ? 0.3 : 0.1
      ..density = 1.0
      ..friction = 0.2;

    final bodyDef = BodyDef()
      ..type = isFalling ? BodyType.dynamic : BodyType.kinematic
      ..position = fallPosition
      ..userData = this; // Useful for collision detection

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
