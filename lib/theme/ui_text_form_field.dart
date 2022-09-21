import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';

class UiTextField {
  static InputDecorationTheme textField = InputDecorationTheme(
    border: const OutlineInputBorder(),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: UiColor.back,
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.back),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.back),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.back),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.warning),
    ),
  );

  static InputDecorationTheme textFieldDark = InputDecorationTheme(
    border: const OutlineInputBorder(),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: UiColor.backDark,
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.backDark),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.backDark),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.backDark),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.warning),
    ),
  );
}
