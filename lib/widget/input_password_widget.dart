import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/service/password_service.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class InputPasswordWidget extends StatefulWidget {
  const InputPasswordWidget({required Function callback, String? label})
      : _callback = callback,
        _label = label;

  final Function _callback;
  final String? _label;

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  final PasswordService passwordService = PasswordService();
  final TextEditingController passwordController = TextEditingController();

  bool _show = true;

  final double buttonSize = 66;

  _showPassword() {
    setState(() => _show = !_show);
  }

  _changeValue(String value) {
    setState(() {
      passwordService.formKey;
    });
    widget._callback(value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Form(
          key: passwordService.formKey,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? UiColor.backDark : UiColor.back,
              borderRadius: BorderRadius.circular(UiBorder.rounded),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      buttonSize -
                      UiSize.paddingButtonFull,
                  child: TextFormField(
                    validator: (value) {
                      setState(() {
                        passwordService.validatePassword(value!);
                      });
                      return null;
                    },
                    // passwordService.validatePassword(value!),
                    onChanged: (value) => _changeValue(value),
                    obscureText: _show,
                    style: Theme.of(context).textTheme.headline2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: UiPadding.large,
                        vertical: UiPadding.small,
                      ),
                      hintText: widget._label ?? 'senha',
                      hintStyle: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: buttonSize,
                  decoration: BoxDecoration(
                    color: isDark ? UiColor.backDark : UiColor.back,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(UiBorder.rounded),
                    ),
                  ),
                  child: ButtonHeadline2(
                    label: _show ? 'mostrar' : 'ocultar',
                    callback: (value) => _showPassword(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
