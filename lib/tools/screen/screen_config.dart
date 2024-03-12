import 'package:flutter/widgets.dart';

import 'screen_tool.dart';

class ScreenConfig extends StatelessWidget {
  const ScreenConfig({
    required this.builder,
    this.designSize = ScreenTool.defaultSize,
    this.allowFontScaling = false,
    super.key,
  });

  final Widget Function() builder;

  final Size designSize;

  final bool allowFontScaling;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenTool().init(
            constraints,
            designSize: designSize,
            allowFontScaling: allowFontScaling,
          );
        }
        return builder();
      },
    );
  }
}
