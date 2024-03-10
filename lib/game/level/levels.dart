import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

import '../../tools/hive_tool.dart';
import '../../tools/image/image_tool.dart';
import '../game_state.dart';
import 'level.dart';
import 'levels_inner.dart';

class Levels {
  static bool isLastLevel(int level) => level > topLevel - 1;

  static int get topLevel => kLevels.length;

  static Future<int> generateLevel() async {
    if (!inited) await setDefaultLevels();
    if (!GameState.gameSetting.random) return 1;
    while (true) {
      if (topLevel < 1) {
        kLevels.clear();
        kLevels.addAll(LevelsInner.levels['friut']!);
      }
      final level = topLevel < 2 ? 1 : (Random().nextInt(topLevel - 1) + 1);
      if (level < topLevel / 2) return level;
    }
  }

  static double radius(int level) {
    return !GameState.gameSetting.levelUp
        ? (topLevel * 2 + 2) - level * 2.0
        : 2.0 + level * 2.0;
  }

  static Sprite sprite(int level) {
    if (!GameState.gameSetting.levelUp) {
      level = topLevel + 1 - level;
    }
    return Sprite(ImageTool.image(kLevels[level - 1].image));
  }

  static Image image(int level) {
    if (!GameState.gameSetting.levelUp) {
      level = topLevel + 1 - level;
    }
    return ImageTool.image(kLevels[level - 1].image);
  }

  static String imagePath(int level) {
    if (!GameState.gameSetting.levelUp) {
      level = topLevel + 1 - level;
    }
    return kLevels[level - 1].image;
  }

  static final kLevels = <Level>[];

  static String background = 'bg.png';

  static Future<void> setBackground(String path) async {
    background = path;
    await HiveTool().set<String>('background', background);
  }

  static bool get inited => kLevels.isNotEmpty;

  static Future<void> init() async {
    if (inited) return;
    final bg = await HiveTool().get<String>('background');
    if (bg != null) {
      background = bg;
    } else {
      await HiveTool().set<String>('background', background);
    }
    final result = await HiveTool().get<String>('kLevels');
    if (result == null) {
      await setDefaultLevels();
      return;
    }
    final levels = Level.fromJsons(result);
    await sets(levels);
    return;
  }

  static Future<void> setDefaultLevels() async {
    return await sets(LevelsInner.levels['friut']!);
  }

  static Future<void> updates() async {
    final result = Level.toJsons(kLevels);
    await HiveTool().set<String>('kLevels', result);
  }

  static Future<void> sets(List<Level> levels) async {
    kLevels.clear();
    kLevels.addAll(levels);
    await updates();
  }

  static Future<void> add(Level level, {int? index}) async {
    index ??= kLevels.length;
    if (index > kLevels.length) return;
    kLevels.insert(index, level);
    await updates();
  }

  static Future<void> del({int? index}) async {
    index ??= kLevels.length - 1;
    if (index > kLevels.length - 1) return;
    kLevels.removeAt(index);
    await updates();
  }

  static Future<void> update(Level level, {int? index}) async {
    index ??= kLevels.length - 1;
    if (index > kLevels.length - 1) return;
    kLevels[index] = level;
    await updates();
  }
}
