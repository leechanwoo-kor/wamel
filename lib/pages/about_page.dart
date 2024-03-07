import 'package:flutter/material.dart';

import '../tools/navigator_tool.dart';
import '../tools/screen/screen_config.dart';
import '../tools/screen/screen_extension.dart';
import '../tools/url_tool.dart';
import '../widgets/base_widget.dart';
import '../widgets/pulse.dart';

class AboutPage extends StatelessWidget {
  void _back() {
    NavigatorTool.pop();
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
                lExpanded(flex: 0, child: Container()),
                lExpanded(flex: 10, child: Container()),
                lText(
                  'A',
                  bold: true,
                  size: 18,
                  color: Colors.grey[600] ?? Colors.black, overflow: TextOverflow.clip,
                ),
                lExpanded(flex: 0, child: Container()),
                lText(
                  'Work',
                  bold: true,
                  size: 36,
                    color: Colors.black, overflow: TextOverflow.clip,
                ),
                lExpanded(flex: 0, child: Container()),
                lText(
                  'by',
                  bold: true,
                  size: 18,
                  color: Colors.grey[600] ?? Colors.black, overflow: TextOverflow.clip,
                ),
                lExpanded(flex: 0, child: Container()),
                Image.asset(
                  'assets/images/qr.jpg',
                  width: 30.vw,
                ),
                lExpanded(flex: 10, child: _homeSite()),
                _madeWithLove(),
                lExpanded(flex: 0, child: Container()),
                _bottomAction(),
                lExpanded(flex: 0, child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeSite() {
    final url = 'https://xbox.work';
    return GestureDetector(
      onTap: () {
        UrlTool.open(url);
      },
      child: lText(
        url,
        color: Colors.blue, size: 0.0, bold: false, overflow: TextOverflow.clip,
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
            lExpanded(flex: 0, child: Container()),
          ],
        ),
      );

  Widget _madeWithLove() => Row(
        children: [
          lExpanded(flex: 0, child: Container()),
          lText(
            'Made with ',
            bold: true,
            size: 18,
            color: Colors.grey[600]!, overflow: TextOverflow.clip,
          ),
          Pulse(
            child: Icon(
              Icons.favorite,
              size: 5.vw,
              color: Colors.red,
            ),
          ),
          lExpanded(flex: 0, child: Container()),
        ],
      );

  Widget _bottomAction() => Row(
        children: [
          lExpanded(flex: 0, child: Container()),
          lText(
            'Powered by',
            bold: true,
            size: 18,
            color: Colors.grey[600]!, overflow: TextOverflow.clip,
          ),
          lWidth(5.vw),
          FlutterLogo(size: 8.vw),
          Icon(
            Icons.close,
            size: 5.vw,
            color: Colors.black54,
          ),
          Image.asset(
            'assets/images/flame.png',
            width: 8.vw,
          ),
          lExpanded(flex: 0, child: Container()),
        ],
      );
}
