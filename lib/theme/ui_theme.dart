import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/theme/ui_color.dart';

ValueNotifier<Brightness> currentTheme = ValueNotifier(Brightness.light);

class UiTheme {
  static setTheme() {
    currentTheme.value =
        WidgetsBinding.instance!.platformDispatcher.platformBrightness;
    changeTheme();
  }

  static changeTheme() {
    bool isDark = currentTheme.value == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarColor: isDark ? UiColor.backDark : UiColor.back,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? UiColor.backDark : UiColor.back,
      ),
    );

    ThemeData();
  }

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: UiColor.back,
    fontFamily: 'nunito',
    // appBarTheme:
    //     const AppBarTheme(backgroundColor: UiColor.primary, elevation: 0),
    // // inputDecorationTheme: UiTextFormField.primary,
    // textSelectionTheme:
    //     const TextSelectionThemeData(cursorColor: UiColor.primary),
  );

  static ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: UiColor.backDark,
    fontFamily: 'nunito',
  );
}
