import 'package:flutter/cupertino.dart';

import '../tools/navigator_tool.dart';

class DialogTool {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String content,
    required Function action,
    required String actionText,
  }) async {
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('$title'),
            content: Text('$content'),
            actions: <Widget>[
              if (actionText != null)
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (action != null) action();
                  },
                  child: Text('$actionText'),
                ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  static bool showing = false;

  static void loading(String title) {
    showing = true;
    showCupertinoDialog(
        context: NavigatorTool.gContext!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('$title'),
            content: Container(
              padding: EdgeInsets.all(10),
              child: Text('잠시만 기다려 주십시오...'),
            ),
          );
        });
  }

  static Future<void> close() async {
    if (!showing) return;
    Navigator.of(NavigatorTool.gContext!).pop();
    showing = false;
  }
}
