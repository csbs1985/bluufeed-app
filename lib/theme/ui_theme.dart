import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text.dart';
import 'package:universe_history_app/theme/ui_text_form_field.dart';

ValueNotifier<Brightness> currentTheme = ValueNotifier(
    WidgetsBinding.instance.platformDispatcher.platformBrightness);

class UiTheme {
  static setTheme() {
    currentTheme.value =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
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
    appBarTheme: const AppBarTheme(
      backgroundColor: UiColor.main,
      elevation: 0,
    ),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiColor.main),
    fontFamily: 'nunito',
    scaffoldBackgroundColor: UiColor.main,
    textButtonTheme: TextButtonThemeData(style: UiButton.button),
    inputDecorationTheme: UiTextField.textField,
    textTheme: const TextTheme(
      headline1: UiTextLight.headline1,
      headline2: UiTextLight.headline2,
      headline3: UiTextLight.headline3,
      headline4: UiTextLight.headline4,
      headline5: UiTextLight.headline5,
      headline6: UiTextLight.headline6,
    ),
  );

  static ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: UiColor.mainDark,
    fontFamily: 'nunito',
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiColor.mainDark),
    textButtonTheme: TextButtonThemeData(style: UiButton.buttonDark),
    inputDecorationTheme: UiTextField.textFieldDark,
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
