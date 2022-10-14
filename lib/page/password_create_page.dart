import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/password_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/widget/input_password_widget.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class PasswordCreatePage extends StatefulWidget {
  const PasswordCreatePage({super.key});

  @override
  State<PasswordCreatePage> createState() => _PasswordCreatePageState();
}

class _PasswordCreatePageState extends State<PasswordCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  final PasswordService passwordService = PasswordService();
  final TextEditingController _passwordController = TextEditingController();
  final ToastWidget toastWidget = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  _register(BuildContext context) async {
    if (passwordService.validateForm()) {
      try {
        print('object******************');
      } on Exception catch (error) {
        debugPrint('ERROR => register: ' + error.toString());
      }
    }
    // passwordService.validatePassword(_passwordController.text);

    // if (passwordService.errorMessage == "") {
    //   // if (currentForm.value == FormEnum.FORGOT.value) {
    //   //   authService.changePassword(context, currentEmail.value);
    //   // } else {
    //   //   await authService
    //   //       .register(context, currentEmail.value, _passwordController.text)
    //   //       .catchError((error) =>
    //   //           debugPrint('ERROR => _checkEmail: ' + error.toString()));
    //   // }
    //   print('teste');
    // } else {
    //   toastWidget.toast(
    //       context, ToastEnum.WARNING.value, passwordService.errorMessage);
    // }
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
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Headline1(title: 'Senha'),
                const TextAnimationWidget(
                  text: 'a senha ajuda a manter seus dados seguros...',
                ),
                const SizedBox(height: UiPadding.large),
                const Headline2(
                  text:
                      'Digite uma senha seguindo o padrão abaixo e a confirme.'
                      '\n\n'
                      '- deve ter de seis (6) à vinte (20) caracteres'
                      '\n'
                      '- deve ter somente letras, números e caracteres especiais'
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
                Button3dWidget(
                  callback: (value) => _register(context),
                  label: 'confirmar',
                  style: ButtonStyleEnum.PRIMARY.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
