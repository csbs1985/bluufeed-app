import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_form_field.dart';

class UiTheme {
  static ThemeData theme1 = ThemeData(
    scaffoldBackgroundColor: UiColor.comp_1,
    fontFamily: 'nunito-regular',
    appBarTheme:
        const AppBarTheme(backgroundColor: UiColor.comp_1, elevation: 0),
    inputDecorationTheme: UiTextFormField.primary,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: UiColor.first),
  );
}
