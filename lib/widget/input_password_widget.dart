import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/service/password_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/material.dart';

class InputPasswordWidget extends StatefulWidget {
  const InputPasswordWidget({
    required Function callback,
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
  })  : _callback = callback,
        _context = context,
        _controller = controller,
        _hint = hint;

  final Function _callback;
  final BuildContext _context;
  final TextEditingController _controller;
  final String _hint;

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  final PasswordService passwordService = PasswordService();

  final String _errorMessage = '';
  bool _show = true;

  _showPassword() {
    setState(() => _show = !_show);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          color: isDark ? UiColor.mainDark : UiColor.main,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        UiSize.bottomInput -
                        UiSize.paddingButtonFull,
                    child: TextFormField(
                      validator: (value) =>
                          passwordService.validatePassword(value!),
                      controller: widget._controller,
                      obscureText: _show,
                      style: Theme.of(context).textTheme.headline2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: UiPadding.large,
                          vertical: UiPadding.small,
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: UiColor.warning),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(UiBorder.rounded),
                            bottomLeft: Radius.circular(UiBorder.rounded),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDark ? UiColor.backDark : UiColor.back),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(UiBorder.rounded),
                            bottomLeft: Radius.circular(UiBorder.rounded),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(UiBorder.rounded),
                            bottomLeft: Radius.circular(UiBorder.rounded),
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: UiColor.warning),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(UiBorder.rounded),
                            bottomLeft: Radius.circular(UiBorder.rounded),
                          ),
                        ),
                        hintText: widget._hint,
                        hintStyle: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: UiSize.bottomInput,
                    height: UiSize.input,
                    decoration: BoxDecoration(
                      color: isDark ? UiColor.backDark : UiColor.back,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(UiBorder.rounded),
                        bottomRight: Radius.circular(UiBorder.rounded),
                      ),
                    ),
                    child: ButtonHeadline2(
                      label: _show ? 'mostrar' : 'ocultar',
                      callback: (value) => _showPassword(),
                    ),
                  ),
                ],
              ),
              if (_errorMessage.isNotEmpty)
                Text(_errorMessage, style: UiText.error),
            ],
          ),
        );
      },
    );
  }
}
