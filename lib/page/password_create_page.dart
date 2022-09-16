import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/service/email_service.dart';
import 'package:universe_history_app/service/password_service.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/app_bar_widget.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';
import 'package:universe_history_app/widget/input_password_widget.dart';
import 'package:universe_history_app/widget/space_x_large.widget.dart';
import 'package:universe_history_app/widget/text_animation_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class PasswordCreatePage extends StatefulWidget {
  const PasswordCreatePage({super.key});

  @override
  State<PasswordCreatePage> createState() => _PasswordCreatePageState();
}

class _PasswordCreatePageState extends State<PasswordCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final AuthService authService = AuthService();
  final PasswordClass passwordClass = PasswordClass();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  final String _regx =
      r'^(?=.*[A-Z])(?=.*[!#@$%&])(?=.*[0-9])(?=.*[a-z]).{6,20}$';

  String _errorMessage = '';

  _validatePassword() {
    if (_passwordController.text.isEmpty) _errorMessage = 'informe sua senha';
    if (_passwordConfirmController.text.isEmpty)
      _errorMessage = 'informe a confrimação de senha';
    if (_passwordController.text.length < 6 ||
        _passwordController.text.length > 20)
      _errorMessage = 'a senha deve ter entre 6 e 20 caracteres';
    if (!RegExp(_regx).hasMatch(_passwordController.text))
      _errorMessage = 'senha informado não é válido';
    if (_passwordController.text != _passwordConfirmController.text)
      return 'a senha e a confirmação devem ser identicas';
    _errorMessage = '';
  }

  _login(BuildContext context) async {
    _validatePassword();

    if (_errorMessage == '') {
      await authService
          .register(context, currentEmail.value, _passwordController.text)
          .catchError((error) =>
              debugPrint('ERROR => _checkEmail: ' + error.toString()));
    } else {
      toast.toast(context, ToastEnum.WARNING.value, _errorMessage);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Criar senha'),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(UiPadding.xLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(UiIcon.identity),
                const SpaceXLargeWidget(),
                const TextAnimationWidget(text: 'agora vem a senha...'),
                const SizedBox(height: UiPadding.large),
                const TextWidget(
                  text: 'Crie uma senha seguindo o padrão abaixo e a confirme.'
                      '\n\n'
                      '- deves ter somente letras, números e caracteres especiais'
                      '\n'
                      '- deve ter no mínimo uma letra maiúscula e minúscula'
                      '\n'
                      '- deve ter no mínimo um (1) número'
                      '\n'
                      '- deve ter no mínimo caractere especial',
                ),
                const SizedBox(height: UiPadding.large),
                InputPasswordWidget(
                  callback: (value) => _passwordController.text = value,
                ),
                const SizedBox(height: UiPadding.large),
                InputPasswordWidget(
                  confirm: true,
                  callback: (value) => _passwordConfirmController.text = value,
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _login(context),
                  label: 'criar',
                  style: ButtonStyleEnum.PRIMARY.value,
                  size: ButtonSizeEnum.LARGE.value,
                  padding: UiSize.paddingPageSmall,
                ),
                const SizedBox(height: UiPadding.large),
                ButtonTextWidget(
                  callback: (value) => Navigator.pushNamed(
                      context, PageEnum.FORGOT_PASSWORD.value),
                  label: 'esqueci a senha',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
