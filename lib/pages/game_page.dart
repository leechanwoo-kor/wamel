import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/my_game.dart';
import '../tools/sensor_tool.dart';
import '../tools/system_tool.dart';

class GamePage extends StatefulWidget {
  final bool hide;
  const GamePage({super.key, required this.hide});
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    SensorTool.start();
  }

  @override
  void dispose() {
    SensorTool.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) {
            SystemTool.changeStatusBarColor();
            return GameWidget(
              game: MyGame(
                hide: widget.hide,
              ),
            );
          },
        ),
      ),
    );
  }
}
