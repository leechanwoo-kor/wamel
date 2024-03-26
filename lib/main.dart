import 'package:flutter/material.dart';
import 'package:wamel/wamel/wamel_widget.dart';

import 'pages/home_page.dart';
import 'tools/navigator_tool.dart';
import 'tools/system_tool.dart';

// void main() async {
void main() {
  runApp(
    const WamelWidget(),
  );
  // runApp(const MyApp());
  // SystemTool.keepPortrait();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'watermelon',
      navigatorObservers: [NavigatorTool()],
      home: const HomePage(),
    );
  }
}
