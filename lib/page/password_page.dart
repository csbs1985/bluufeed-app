import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/service/device_service.dart';
import 'package:bluuffed_app/service/password_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final ActivityClass activityClass = ActivityClass();
  final AuthService authService = AuthService();
  final DeviceService deviceService = DeviceService();
  final PasswordService passwordService = PasswordService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordOldController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  bool _show = true;
  String _errorMessage = '';

  final double buttonSize = 66;

  @override
  void initState() {
    currentPasswordType.value = PasswordTypeEnum.CREATE.value;
    super.initState();
  }

  _showPassword() {
    setState(() => _show = !_show);
  }

  String _getHeadline1() {
    if (currentPasswordType.value == PasswordTypeEnum.LOGIN.value)
      return 'Senha';
    if (currentPasswordType.value == PasswordTypeEnum.CREATE.value)
      return 'Criar senha';
    return 'Alterar senha';
  }

  String _getTextAnimationWidget() {
    if (currentPasswordType.value == PasswordTypeEnum.LOGIN.value)
      return 'agora vem a senha...';
    if (currentPasswordType.value == PasswordTypeEnum.CREATE.value)
      return 'a senha ajuda a manter seus dados seguros...';
    return 'é sempre bom mudar a senha...';
  }

  String _getHeadline2() {
    if (currentPasswordType.value == PasswordTypeEnum.LOGIN.value)
      return 'informe sua senha...';

    return 'Digite uma senha seguindo o padrão abaixo e a confirme.'
        '\n\n'
        '- deve ter de seis (6) à vinte (20) caracteres'
        '\n'
        '- deve ter somente letras, números e caracteres especiais'
        '\n'
        '- deve ter no mínimo uma letra maiúscula e minúscula'
        '\n'
        '- deve ter no mínimo um (1) número'
        '\n'
        '- deve ter no mínimo um (1) caractere especial';
  }

  _login(BuildContext context) async {
    setState(() => _errorMessage =
        passwordService.validatePassword(_passwordController.text));

    if (_errorMessage.isEmpty) {
      try {
        await authService
            .login(context, currentEmail.value, _passwordController.text)
            .then((result) => Navigator.pushNamed(context, '/'))
            .catchError(
              (error) =>
                  debugPrint('ERROR => _checkEmail: ' + error.toString()),
            );
      } on Exception catch (error) {
        debugPrint('ERROR => login: ' + error.toString());
      }
    }
  }

  _register(BuildContext context) async {
    setState(() {
      _errorMessage =
          passwordService.validatePassword(_passwordController.text);
    });

    if (_errorMessage.isEmpty) {
      try {
        await authService.register(
          context,
          currentEmail.value,
          _passwordController.text,
        );
      } on Exception catch (error) {
        debugPrint('ERROR => register: ' + error.toString());
      }
    }
  }

  _update(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // TODO: editar senha
      try {} on Exception catch (error) {
        debugPrint('ERROR => update: ' + error.toString());
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWidget(option: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Headline1(title: _getHeadline1()),
                TextAnimationWidget(text: _getTextAnimationWidget()),
                const SizedBox(height: UiPadding.large),
                Headline2(text: _getHeadline2()),
                const SizedBox(height: UiPadding.large),
                _inputPasswordWidget(
                  context,
                  _passwordController,
                  currentPasswordType.value == PasswordTypeEnum.EDIT.value
                      ? 'senha atual'
                      : 'senha',
                ),
                if (currentPasswordType.value == PasswordTypeEnum.EDIT.value)
                  const SizedBox(height: UiPadding.large),
                if (currentPasswordType.value == PasswordTypeEnum.EDIT.value)
                  _inputPasswordWidget(
                    context,
                    _passwordOldController,
                    'nova senha',
                  ),
                const SizedBox(height: UiPadding.large),
                if (currentPasswordType.value == PasswordTypeEnum.LOGIN.value)
                  Button3dWidget(
                    callback: (value) => _login(context),
                    label: 'entrar',
                    style: ButtonStyleEnum.PRIMARY.value,
                  ),
                if (currentPasswordType.value == PasswordTypeEnum.CREATE.value)
                  Button3dWidget(
                    callback: (value) => _register(context),
                    label: 'criar senha',
                    style: ButtonStyleEnum.PRIMARY.value,
                  ),
                if (currentPasswordType.value == PasswordTypeEnum.EDIT.value)
                  Button3dWidget(
                    callback: (value) => _update(context),
                    label: 'alterar senha',
                    style: ButtonStyleEnum.PRIMARY.value,
                  ),
                const SizedBox(height: UiPadding.large),
                if (currentPasswordType.value == PasswordTypeEnum.LOGIN.value)
                  ButtonHeadline2(
                    callback: (value) => Navigator.pushNamed(
                      context,
                      PageEnum.FORGOT_PASSWORD.value,
                    ),
                    label: 'esqueci a senha',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputPasswordWidget(
    BuildContext context,
    TextEditingController _controller,
    String _hint,
  ) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark ? UiColor.backDark : UiColor.back,
                border: Border.all(
                  width: 1,
                  color: _errorMessage.isNotEmpty
                      ? UiColor.warning
                      : isDark
                          ? UiColor.backDark
                          : UiColor.back,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(UiBorder.rounded),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        buttonSize -
                        UiSize.paddingButtonFull -
                        2,
                    child: TextFormField(
                      // validator: (value) =>
                      //     passwordService.validatePassword(value!),
                      controller: _controller,
                      obscureText: _show,
                      style: Theme.of(context).textTheme.headline2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: UiPadding.large,
                          vertical: UiPadding.small,
                        ),
                        hintText: _hint,
                        hintStyle: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: buttonSize,
                    height: UiSize.input,
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
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  UiPadding.large,
                  UiPadding.medium,
                  0,
                  0,
                ),
                child: Text(_errorMessage, style: UiText.error),
              ),
          ],
        );
      },
    );
  }
}
