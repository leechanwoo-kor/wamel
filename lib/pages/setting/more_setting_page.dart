import 'package:flutter/material.dart';

import '../../game/game_setting.dart';
import '../../game/game_state.dart';
import '../../tools/navigator_tool.dart';
import '../../tools/screen/screen_config.dart';
import '../../tools/screen/screen_extension.dart';
import '../../widgets/base_widget.dart';
import 'background_page.dart';
import 'inner_level_page.dart';
import 'level_setting_page.dart';

class MoreSettingPage extends StatelessWidget {
  const MoreSettingPage({super.key});

  void _back() {
    NavigatorTool.pop();
  }

  GameSetting get setting => GameState.gameSetting;

  @override
  Widget build(BuildContext context) {
    return ScreenConfig(
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                _topAction(),
                lExpanded(),
                _button('Theme', const InnerLevelPage()),
                lHeight(10.vw),
                _button('Background', const BackgroundPage()),
                lHeight(10.vw),
                _button('Picture', const LevelSettingPage()),
                lExpanded(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topAction() => Container(
        padding: EdgeInsets.all(5.vw),
        child: Row(
          children: [
            lIconButton(
              Icons.chevron_left,
              size: 10.vw,
              color: Colors.black,
              onTap: _back,
            ),
            lExpanded(
                child: lText(
              'Advanced Settings',
              bold: true,
              size: 18,
            )),
            lIconButton(
              Icons.chevron_left,
              size: 10.vw,
              color: Colors.transparent,
            ),
          ],
        ),
      );

  Widget _button(String lable, Widget page) => lButton(lable,
          height: 5.vw * 2.2,
          colorBg: Colors.black,
          colorText: Colors.white, onTap: () {
        NavigatorTool.push(page);
      });
}
