import 'dart:convert';

import '../game/game_state.dart';

class GameSetting {
  bool levelUp;
  bool random;
  bool music;
  bool bloom;
  bool gravity;

  GameSetting({
    this.levelUp = true,
    this.random = true,
    this.music = true,
    this.bloom = true,
    this.gravity = false,
  });

  // GameSetting.fromJson(Map<String, dynamic> json) {
  //   levelUp = json['levelUp'];
  //   random = json['random'];
  //   music = json['music'];
  //   bloom = json['bloom'];
  //   gravity = json['gravity'];
  // }

  GameSetting.fromJson(Map<String, dynamic> json)
      : levelUp = json['levelUp'] as bool,
        random = json['random'] as bool,
        music = json['music'] as bool,
        bloom = json['bloom'] as bool,
        gravity = json['gravity'] as bool;

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
