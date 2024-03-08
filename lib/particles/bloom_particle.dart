import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import '../game/game_state.dart';
import '../game/my_game.dart';
import '../tools/size_tool.dart';

class BloomParticle {
  MyGame gameRef;
  BloomParticle(this.gameRef);

  static final List<Color> bloomColors = [
    Colors.amberAccent,
    Colors.pink,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.deepOrange,
  ];

  static final Random rnd = Random();

  double randomSpeed(double radius) =>
      (2 + rnd.nextDouble() * 1) * gameRef.vw(radius);
  double randomRadius(double radius) =>
      (2 + rnd.nextDouble() * 1) * gameRef.vw(radius);
  double randomAngle(double angle) => angle + rnd.nextDouble() * pi / 6;
  double randomTime(double radius) => 0.2 + rnd.nextDouble() * 0.5;
  int randomCount(double radius) => 6 + rnd.nextInt(4) + (radius ~/ 2);
  Color randomColor(double radius) =>
      bloomColors[(radius ~/ 2) % bloomColors.length];

  void show(Vector2 position, double radius) {
    if (!GameState.gameSetting.bloom) return;

    final particleCount = randomCount(radius);
    final color = bloomColors[radius.toInt() % bloomColors.length];

    gameRef.add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: particleCount,
          lifespan: randomTime(radius),
          generator: (i) {
            final angle = randomAngle((2 * pi / particleCount) * i);
            return AcceleratedParticle(
              position: position,
              speed: Vector2(sin(angle), cos(angle)) * randomSpeed(radius),
              acceleration:
                  Vector2(sin(angle), cos(angle)) * -randomRadius(radius),
              child: CircleParticle(
                radius: radius,
                paint: Paint()..color = color,
              ),
            );
          },
        ),
      ),
    );
  }
}
