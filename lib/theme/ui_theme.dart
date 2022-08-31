import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class UiTheme {
  static ValueNotifier<Brightness> theme = ValueNotifier(Brightness.light);

  static setTheme() {
    theme.value =
        WidgetsBinding.instance!.platformDispatcher.platformBrightness;
  }
}
