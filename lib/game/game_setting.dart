import 'dart:convert';

import '../game/game_state.dart';

class GameSetting {
  bool levelUp;
  bool random;
  bool music;
  bool bloom;
  bool gravity;

  GameSetting({
    this.levelUp,
    this.random,
    this.music,
    this.bloom,
    this.gravity,
  }) {
    levelUp ??= true;
    random ??= true;
    music ??= true;
    bloom ??= true;
    gravity ??= false;
  }

  GameSetting.fromJson(Map<String, dynamic> json) {
    levelUp = json['levelUp'];
    random = json['random'];
    music = json['music'];
    bloom = json['bloom'];
    gravity = json['gravity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['levelUp'] = levelUp;
    data['random'] = random;
    data['music'] = music;
    data['bloom'] = bloom;
    data['gravity'] = gravity;
    return data;
  }

  String toJsonStr() => jsonEncode(toJson());

  static GameSetting fromJsonStr(String result) {
    return GameSetting.fromJson(jsonDecode(result));
  }

  Future<void> update() async => GameState.updateSetting(this);
}
