import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class XYZ {
  XYZ(this.x, this.y, this.z);
  final double x;
  final double y;
  final double z;

  @override
  String toString() => 'x: $x, y: $y, z: $z';
}

class SensorTool {
  static StreamSubscription<dynamic>? _stream;

  static XYZ _xyz = XYZ(0, 0, 0);

  static XYZ get xyz => _xyz;

  static Future<void> start() async {
    await stop();
    _stream = accelerometerEvents.listen((data) {
      _xyz = XYZ(data.x, data.y, data.z);
    });
  }

  static Future<void> stop() async {
    await _stream?.cancel();
  }
}
