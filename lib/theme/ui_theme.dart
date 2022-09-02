import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text.dart';

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
        statusBarColor: isDark ? UiColor.mainDark : UiColor.main,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? UiColor.mainDark : UiColor.main,
      ),
    );

    ThemeData();
  }

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: UiColor.main,
    fontFamily: 'nunito',
    textTheme: const TextTheme(
      headline1: UiTextLight.headline1,
      headline2: UiTextLight.headline2,
      headline3: UiTextLight.headline3,
      headline4: UiTextLight.headline4,
      headline5: UiTextLight.headline5,
      headline6: UiTextLight.headline6,
    ),
    // appBarTheme:
    //     const AppBarTheme(backgroundColor: UiColor.primary, elevation: 0),
    // // inputDecorationTheme: UiTextFormField.primary,
    // textSelectionTheme:
    //     const TextSelectionThemeData(cursorColor: UiColor.primary),
  );

  static ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: UiColor.mainDark,
    fontFamily: 'nunito',
    textTheme: const TextTheme(
      headline1: UiTextDark.headline1,
      headline2: UiTextDark.headline2,
      headline3: UiTextDark.headline3,
      headline4: UiTextDark.headline4,
      headline5: UiTextDark.headline5,
      headline6: UiTextDark.headline6,
    ),
  );
}
