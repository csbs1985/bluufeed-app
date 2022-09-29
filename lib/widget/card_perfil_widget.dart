import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardPerfilWidget extends StatefulWidget {
  const CardPerfilWidget({
    required String label,
    required String number,
    required String icon,
    String? link,
  })  : _label = label,
        _number = number,
        _icon = icon,
        _link = link;

  final String _label;
  final String _number;
  final String _icon;
  final String? _link;

  @override
  State<CardPerfilWidget> createState() => _CardPerfilWidgetState();
}

class _CardPerfilWidgetState extends State<CardPerfilWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return TextButton(
          onPressed: () => Navigator.pushNamed(context, widget._link!),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(UiPadding.large),
            backgroundColor:
                isDark ? UiColor.buttonSecondaryDark : UiColor.buttonSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(widget._icon),
              const SizedBox(height: UiPadding.large),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: widget._label),
                  TextWidget(text: widget._number),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
