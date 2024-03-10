import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveTool {
  factory HiveTool() => _singleton;
  HiveTool._internal();

  static final HiveTool _singleton = HiveTool._internal();
  late Box<dynamic> box;
  final String boxName = 'app';

  bool get inited => Hive.isBoxOpen(boxName);

  Future<void> init() async {
    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
    }
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox(boxName);
    }
  }

  Future<T?> get<T>(String key) async {
    if (!inited) await init();
    return box.get(key);
  }

  Future<void> set<T>(String key, T value) async {
    if (!inited) await init();
    await box.put(key, value);
  }
}
