import '../components/ball.dart';
import '../components/scores.dart';
import '../game/game_setting.dart';
import '../tools/hive_tool.dart';

class GameState {
  static int score = 0;
  static int record = 0;
  static bool isNewRecord = false;
  static GameStatus gameStatus = GameStatus.start;
  static GameSetting gameSetting = GameSetting();
  static Ball? lastBall;
  static Scores? scoreComponent;

  static Future<void> updateScore(int newScore) async {
    score = newScore;
    scoreComponent?.text = GameState.score.toString();
    if (newScore > record) {
      record = newScore;
      isNewRecord = true;
      await HiveTool().set<int>('record', score);
    }
  }

  static Future<void> updateSetting(GameSetting setting) async {
    gameSetting = setting;
    await HiveTool().set<String>('gameSetting', gameSetting.toJsonStr());
  }

  static bool inited = false;

  static Future<void> init() async {
    score = 0;
    isNewRecord = false;
    gameStatus = GameStatus.start;
    lastBall = null;
    await initSetting();
  }

  static Future<void> initSetting() async {
    if (inited) return;
    final r = await HiveTool().get<int>('record');
    if (r != null) record = r;
    final s = await HiveTool().get<String>('gameSetting');
    if (s != null) gameSetting = GameSetting.fromJsonStr(s);
    inited = true;
  }
}

enum GameStatus {
  over,
  win,
  pause,
  start,
}
