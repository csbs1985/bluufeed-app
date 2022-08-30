import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_form_field.dart';

class UiTheme {
  static ValueNotifier<Brightness> tema = ValueNotifier(Brightness.light);

  static setTheme() {
    tema.value = WidgetsBinding.instance!.platformDispatcher.platformBrightness;
    changeTheme();
  }

  static changeTheme() {
    bool isDark = tema.value == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarColor: isDark ? UiColor.first : UiColor.second,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? UiColor.first : UiColor.second,
      ),
    );
  }

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: UiColor.comp_1,
    fontFamily: 'nunito-regular',
    appBarTheme:
        const AppBarTheme(backgroundColor: UiColor.comp_1, elevation: 0),
    inputDecorationTheme: UiTextFormField.primary,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: UiColor.first),
  );
}
