import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';

class UiButton {
  static ButtonStyle button = ButtonStyle(
    backgroundColor:
        const MaterialStatePropertyAll<Color>(UiColor.buttonSecondary),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorder.circle)),
    ),
  );

  static ButtonStyle buttonDark = ButtonStyle(
    backgroundColor:
        const MaterialStatePropertyAll<Color>(UiColor.buttonSecondaryDark),
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
