import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/service/device_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/input_password_widget.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await authService
          .login(context, currentEmail.value, _passwordController.text)
          .then((result) => Navigator.pushNamed(context, '/'))
          .catchError(
            (error) => debugPrint('ERROR => _checkEmail: ' + error.toString()),
          );
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
      appBar: const AppBarBackWidget(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Headline1(title: 'Senha'),
                const TextAnimationWidget(text: 'agora vem a senha...'),
                const SizedBox(height: UiPadding.large),
                const TextWidget(text: 'Informe sua senha.'),
                const SizedBox(height: UiPadding.large),
                InputPasswordWidget(
                  callback: (value) => _passwordController.text = value,
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _login(context),
                  label: 'entrar',
                  style: ButtonStyleEnum.PRIMARY.value,
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
