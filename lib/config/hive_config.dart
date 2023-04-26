import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static start() async {
    await Hive.initFlutter();
    await Hive.openBox('usuario');
  }
}
