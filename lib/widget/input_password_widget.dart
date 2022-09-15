import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';

class InputPasswordWidget extends StatefulWidget {
  const InputPasswordWidget({required Function callback, bool? confirm = false})
      : _callback = callback,
        _confirm = confirm;

  final Function _callback;
  final bool? _confirm;

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool _show = true;

  _showPassword() {
    setState(() => _show = !_show);
  }

  _changeValue(String value) {
    widget._callback(value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          decoration: BoxDecoration(
            color: isDark ? UiColor.backDark : UiColor.back,
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: TextField(
                  autofocus: true,
                  onChanged: (value) => _changeValue(value),
                  obscureText: _show,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: UiPadding.large,
                      vertical: UiPadding.small,
                    ),
                    hintText: widget._confirm! ? 'confirmar senha' : 'senha',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: isDark ? UiColor.backDark : UiColor.back,
                width: 68,
                child: ButtonTextWidget(
                  label: _show ? 'mostrar' : 'ocultar',
                  callback: (value) => _showPassword(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
