import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class UiButton {
  static ButtonStyle button = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll<Color>(UiColor.inatived),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorder.circle)),
    ),
  );

  static ButtonStyle buttonDark = ButtonStyle(
    backgroundColor:
        const MaterialStatePropertyAll<Color>(UiColor.inativedDark),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorder.circle)),
    ),
  );

  static ButtonStyle buttonActived = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll<Color>(UiColor.button),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorder.circle)),
    ),
  );
}
