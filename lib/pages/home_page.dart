import 'package:flutter/material.dart';

import '../game/game_life.dart';
import '../game/game_state.dart';
import '../tools/navigator_tool.dart';
import '../tools/screen/screen_config.dart';
import '../tools/screen/screen_extension.dart';
import '../widgets/base_widget.dart';
import 'about_page.dart';
import 'game_page.dart';
import 'setting/game_setting_page.dart';

class HomePage extends StatelessWidget {
  void _start() {
    GameLife.start();
  }

  void _about() {
    NavigatorTool.push(AboutPage());
  }

  Future<void> _setting() async {
    await GameState.initSetting();
    await NavigatorTool.push(
      GameSettingPage(
        fromHome: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenConfig(
      key: Key('screen_config_key'),
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                _topAction(),
                lExpanded(
                    child: _bottomAction(), flex: 1,
                ),
                _hideGame(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hideGame() => Offstage(
        child: Container(
          width: 1,
          height: 1,
          child: GamePage(hide: true),
        ),
      );

  Widget _topAction() => Container(
        padding: EdgeInsets.all(5.vw),
        child: Row(
          children: [
            lIconButton(
              Icons.info,
              size: 10.vw,
              color: Colors.black,
              onTap: _about,
            ),
            lExpanded(flex: 1, child: Container()),
            lIconButton(
              Icons.settings,
              size: 10.vw,
              color: Colors.black,
              onTap: _setting,
            ),
          ],
        ),
      );

  Widget _bottomAction() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          lButton(
            'Start',
            onTap: _start,
            height: 5.vw * 2.2,
            colorBg: Colors.black,
            colorText: Colors.white, fontSize: 12.0, width: 0.0, radius: 0.0,
          ),
        ],
      );
}
