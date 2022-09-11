import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();
  final ToastWidget toast = ToastWidget();

  final String _regx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  _validateEmail(value) {
    if (value!.isEmpty) return 'informe seu email';
    if (!RegExp(_regx).hasMatch(_emailController.text))
      return 'email informado não é válido';
    return null;
  }

  _validatePassword(value) {
    if (value!.isEmpty) return 'informe sua senha';
    if (value!.length < 6) return 'a senha deve ter no mínimo 6 caracteres';
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      try {
        authService.loginAuthentication(
            _emailController.text, _passwordController.text);
      } on AuthException catch (e) {
        toast.toast(context, ToastEnum.WARNING.value, e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: UiSize.appBar),
                SvgPicture.asset(UiIcon.identity),
                const SizedBox(height: UiPadding.large),
                AnimatedTextKit(
                  isRepeatingAnimation: true,
                  totalRepeatCount: 3,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Seja bem vindo de volta... 😅😍',
                      textStyle: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  autofocus: true,
                  controller: _emailController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => _validateEmail(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: UiPadding.large,
                      vertical: UiPadding.small,
                    ),
                    hintText: 'email',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  autofocus: true,
                  controller: _passwordController,
                  obscureText: true,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.text,
                  validator: (value) => _validatePassword(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: UiPadding.large,
                      vertical: UiPadding.small,
                    ),
                    hintText: 'senha',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _login(),
                  label: 'entrar',
                  style: ButtonStyleEnum.PRIMARY.value,
                  size: ButtonSizeEnum.LARGE.value,
                  padding: UiPadding.large * 2,
                ),
                const SizedBox(height: UiPadding.large),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonTextWidget(
                      callback: (value) => Navigator.of(context)
                          .pushReplacementNamed(PageEnum.REGISTER.value),
                      label: 'ainda não tenho conta',
                    ),
                    ButtonTextWidget(
                      callback: (value) => Navigator.of(context)
                          .pushReplacementNamed(PageEnum.FORGOT_PASSWORD.value),
                      label: 'esqueci a senha',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
