import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:wamel/game/level/levels.dart';
import 'package:wamel/game/my_game.dart';

class Ball extends BodyComponent {
  final Vector2 fallPosition;
  final bool isFalling;
  final int level;
  final double radius;
  bool landed;
  bool levelUp = false;
  bool isRemoved = false;
  bool moving;
  bool bouncing;
  late SpriteComponent spriteComponent;

  Vector2 get size => spriteComponent.size;

  set size(Vector2 newSize) {
    spriteComponent.size = newSize;
  }

  // Vector2 get position =>
  //     viewport.getWorldToScreen(body?.position ?? Vector2.zero());

  // double get radius => _radius * viewport.scale;

  // static Ball create(
  //   Viewport viewport, {
  //   required Vector2 position,
  //   required int level,
  //   bool moving,
  //   bool canFall,
  //   bool landed,
  //   bool bouncing,
  // }) {
  //   position ??= Vector2.zero();
  //   level ??= 1;
  //   canFall ??= false;
  //   landed ??= false;
  //   moving ??= true;
  //   bouncing ??= false;
  //   return Ball(
  //     level: level,
  //     position: position,
  //     canFall: canFall,
  //     landed: landed,
  //     moving: moving,
  //     bouncing: bouncing,
  //     sprite: Levels.sprite(level),
  //     radius: Levels.radius(level) * (viewport.size.x / viewport.scale / 100),
  //   );
  // }

  static Future<Ball> create({
    required MyGame gameRef,
    required Vector2 position,
    required int level,
    bool? moving,
    bool canFall = true,
    bool landed = true,
    bool bounce = true,
  }) async {
    // 필요한 경우 비동기 로딩 작업 수행, 예: 스프라이트 로딩
    final sprite = Levels.sprite(level);
    // Ball 인스턴스 생성 및 초기화
    return Ball(
      fallPosition: position,
      isFalling: canFall,
      level: level,
      radius: Levels.radius(level),
      landed: landed,
      moving: true,
      bouncing: bounce,
      sprite: sprite,
    );
  }

  Ball({
    // required Vector2 position,
    required this.fallPosition,
    required this.isFalling,
    required this.level,
    required this.radius,
    this.landed = false,
    this.moving = true,
    this.bouncing = false,
    Sprite? sprite,
  }) {
    spriteComponent =
        SpriteComponent(sprite: sprite, size: Vector2.all(radius * 2));
  }

  // @override
  // Future<void> onLoad() async {
  //   await super.onLoad();
  //   await add(spriteComponent);
  //   size = Vector2.all(radius * 2);
  //   anchor = Anchor.center;
  // }

  @override
  Body createBody() {
    // final shape = CircleShape()..radius = size.x / 2;
    final shape = CircleShape()..radius = radius;

    // var position = fallPosition.clone();
    // if (!isFalling) {
    //   position.x = viewport.center.x;
    // }
    // var worldPosition = viewport.getScreenToWorld(position);

    // final bodyDef = BodyDef()
    //   ..userData = this
    //   ..angularDamping = 0.1
    //   ..position = worldPosition
    //   ..type = isFalling ? BodyType.DYNAMIC : BodyType.KINEMATIC;

    final bodyDef = BodyDef(
      position: fallPosition,
      userData: this,
      type: isFalling ? BodyType.dynamic : BodyType.kinematic,
    );

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.1
      ..density = 0.1
      ..friction = 0.1;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
