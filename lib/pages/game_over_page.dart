import 'package:flutter/material.dart';

import '../game/game_life.dart';
import '../game/game_state.dart';
import '../game/level/levels.dart';
import '../game/my_game.dart';
import '../tools/image/image_tool.dart';
import '../tools/navigator_tool.dart';
import '../tools/screen/screen_config.dart';
import '../tools/screen/screen_extension.dart';
import '../tools/share_tool.dart';
import '../widgets/base_widget.dart';
import '../widgets/spinner.dart';
import 'setting/game_setting_page.dart';

// ignore: must_be_immutable
class GameOverPage extends StatelessWidget {
  MyGame gameRef;
  bool isWin;

  GameOverPage(
    this.gameRef, {
    required this.isWin,
  }) {
    isWin ??= true;
  }

  void _share() async {
    await ShareTool.share(
        '我合成大西瓜的最高分是${GameState.record}！关注微信号：乂乂又又，回复：大西瓜，就有链接了^^');
  }

  void _retry() {
    NavigatorTool.pop();
    GameLife(gameRef).restart();
  }

  void _home() {
    NavigatorTool.pop();
    GameLife(gameRef).back2Home();
  }

  void _setting() => NavigatorTool.push(
        GameSettingPage(
          fromHome: false,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ScreenConfig(
      key: Key('screen_config_key'),
      builder: () => WillPopScope(
        onWillPop: () async {
          _retry();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black45,
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  lExpanded(child: _topAction(), flex: 1),
                  ...GameState.isNewRecord ? _newRecord() : _normalRecord(),
                  if (isWin)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        _shine(),
                        _topBall(),
                      ],
                    ),
                  lHeight(10.vw),
                  lExpanded(
                    child: _bottomAction(), flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topAction() => Row(
        children: [
          lWidth(10.vw),
          lIconButton(
            Icons.home,
            size: 10.vw,
            color: Colors.white,
            onTap: _home,
          ),
          lExpanded(flex: 1, child: Container()),
          lIconButton(
            Icons.settings,
            size: 10.vw,
            color: Colors.white,
            onTap: _setting,
          ),
          lWidth(10.vw),
        ],
      );

  Widget _bottomAction() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          lButton(
            '공유',
            onTap: _share,
            height: 5.vw * 2.2,
            colorBg: Colors.black,
            colorText: Colors.white,
            fontSize: 0.0,
            width: 0.0,
            radius: 0.0,
          ),
          lButton(
            '다시하기',
            onTap: _retry,
            height: 5.vw * 2.2,
            fontSize: 0.0,
            width: 0.0,
            radius: 0.0,
            colorText: Colors.white,
            colorBg: Colors.black,
          ),
        ],
      );

  List<Widget> _normalRecord() => [
        Text(
          '최고점：${GameState.record}',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        lHeight(10.vw),
        Text(
          '점수：${GameState.score}',
          style: TextStyle(
            fontSize: 36,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        lHeight(10.vw),
      ];

  List<Widget> _newRecord() => [
        Text(
          '신기록',
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        lHeight(5.vw),
        Text(
          '${GameState.score}',
          style: TextStyle(
            fontSize: 36,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        lHeight(10.vw),
      ];

  Widget _shine() {
    return Spinner(
        child: Container(
      width: 90.vw,
      height: 90.vw,
      child: RawImage(
        image: ImageTool.image('shine.png'),
        fit: BoxFit.cover,
      ),
    ));
  }

  Widget _topBall() {
    return Container(
      width: Levels.radius(Levels.topLevel).vw * 2,
      height: Levels.radius(Levels.topLevel).vw * 2,
      child: RawImage(
        image: Levels.image(Levels.topLevel),
        fit: BoxFit.cover,
      ),
    );
  }
}
