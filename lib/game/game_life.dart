import '../pages/game_over_page.dart';
import '../pages/game_page.dart';
import '../pages/setting/game_setting_page.dart';
import '../tools/audio_tool.dart';
import '../tools/navigator_tool.dart';
import 'game_onload.dart';
import 'game_state.dart';
import 'my_game.dart';

class GameLife {
  MyGame gameRef;
  GameLife(this.gameRef);

  static void start() async {
    await GameOnload.init();
    await NavigatorTool.push(GamePage());
  }

  void pause() {
    gameRef.pauseEngine();
    GameState.gameStatus = GameStatus.pause;
  }

  void resume() {
    gameRef.resumeEngine();
    GameState.gameStatus = GameStatus.start;
  }

  void win() {
    AudioTool.win();
    GameState.gameStatus = GameStatus.win;
    NavigatorTool.push(GameOverPage(
      gameRef,
      isWin: true,
    ));
  }

  void dead() {
    AudioTool.dead();
    GameState.gameStatus = GameStatus.over;
    NavigatorTool.push(GameOverPage(
      gameRef,
      isWin: false,
    ));
  }

  void restart() {
    pause();
    NavigatorTool.replace(GamePage());
  }

  void back2Home() {
    NavigatorTool.pop();
  }

  void setting() async {
    pause();
    await NavigatorTool.push(GameSettingPage(
      fromHome: false,
    ));
    resume();
  }
}
