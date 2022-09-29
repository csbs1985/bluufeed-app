import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionButton extends StatefulWidget {
  const OptionButton({
    required Function callback,
    required String label,
    required String icon,
  })  : _callback = callback,
        _label = label,
        _icon = icon;

  final Function _callback;
  final String _label;
  final String _icon;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          height: UiSize.bottomXLarge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          child: TextButton(
            onPressed: () => widget._callback(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark
                  ? UiColor.buttonSecondaryDark
                  : UiColor.buttonSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: UiPadding.small),
                SizedBox(
                  width: 20,
                  child: SvgPicture.asset(widget._icon),
                ),
                const SizedBox(width: UiPadding.medium),
                Text(
                  widget._label,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
