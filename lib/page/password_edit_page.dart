import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/form_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/service/password_service.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/widget/app_bar_widget_old.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/widget/input_password_widget.dart';
import 'package:bluuffed_app/widget/space_x_large.widget.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class PasswordEditPage extends StatefulWidget {
  const PasswordEditPage({super.key});

  @override
  State<PasswordEditPage> createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();
  final PasswordClass passwordClass = PasswordClass();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  final String _regx =
      r'^(?=.*[A-Z])(?=.*[@#%^*>\$@?/[]=+])(?=.*[0-9])(?=.*[a-z]).{6,20}$';

  String _errorMessage = '';

  _login(BuildContext context) async {
    _validatePassword();

    if (_errorMessage == '') {
      if (currentForm.value == FormEnum.FORGOT.value) {
        authService.changePassword(context, currentEmail.value);
      } else {
        await authService
            .register(context, currentEmail.value, _passwordController.text)
            .catchError((error) =>
                debugPrint('ERROR => _checkEmail: ' + error.toString()));
      }
    } else {
      toast.toast(context, ToastEnum.WARNING.value, _errorMessage);
    }
  }

  _validatePassword() {
    if (_passwordController.text.isEmpty) _errorMessage = 'informe sua senha';
    if (_passwordController.text.length < 6 ||
        _passwordController.text.length > 20)
      _errorMessage = 'a senha deve ter entre 6 e 20 caracteres';
    if (!RegExp(_regx).hasMatch(_passwordController.text))
      _errorMessage = 'senha informado não é válido';
    _errorMessage = '';
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetOld(title: 'Alterar senha'),
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
                const TextAnimationWidget(
                  text: 'é sempre bom mudar a senha...',
                ),
                const SizedBox(height: UiPadding.large),
                const TextWidget(
                  text:
                      'Digite uma senha seguindo o padrão abaixo e a confirme.'
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
                  label: 'senha atual',
                  callback: (value) => _passwordController.text = value,
                ),
                const SizedBox(height: UiPadding.large),
                InputPasswordWidget(
                  label: 'nova senha',
                  callback: (value) => _passwordController.text = value,
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _login(context),
                  label: 'alterar senha',
                  style: ButtonStyleEnum.PRIMARY.value,
                  size: ButtonSizeEnum.LARGE.value,
                  padding: UiSize.paddingPageSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
