import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/app_bar_back_widget.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();
  final ToastWidget toast = ToastWidget();
  final UsersFirestore usersFirestore = UsersFirestore();

  final String _emailRegx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  void _login(BuildContext context) {
    _validateEmail(context);
  }

  _validateEmail(BuildContext context) {
    if (_emailController.text.isEmpty) {
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        'informe seu email',
      );
    } else if (!RegExp(_emailRegx).hasMatch(_emailController.text)) {
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        'email informado não é válido.',
      );
    } else
      _checkEmailDb();
  }

  _checkEmailDb() async {
    await usersFirestore
        .getUserEmail(_emailController.text)
        .then((result) => {
              setState(() {
                if (result.size > 0) {
                  _validatePassword(context);
                } else {
                  toast.toast(
                    context,
                    ToastEnum.WARNING.value,
                    'email informado não cadastrato.',
                  );
                }
              })
            })
        .catchError((error) => debugPrint('ERROR => _checkEmailDb: $error'));
  }

  _validatePassword(BuildContext context) {
    if (_passwordController.text.isEmpty) {
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        'informe sua senha.',
      );
    } else
      _loginFirebase(context);
  }

  void _loginFirebase(BuildContext context) async {
    try {
      await authService.loginAuthentication(
        _emailController.text,
        _passwordController.text,
      );
      toast.toast(
        context,
        ToastEnum.SUCCESS.name,
        'bem vindo de volta.',
      );
      Navigator.of(context).pop();
    } on AuthException {
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        'senha informada incorreta.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackWidget(),
      body: Container(
        padding: const EdgeInsets.all(UiPadding.xLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            TextField(
              autofocus: true,
              controller: _emailController,
              style: Theme.of(context).textTheme.headline2,
              keyboardType: TextInputType.emailAddress,
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
            TextField(
              autofocus: true,
              controller: _passwordController,
              style: Theme.of(context).textTheme.headline2,
              keyboardType: TextInputType.text,
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
              callback: (value) => _login(context),
              label: 'entrar',
              style: ButtonStyleEnum.PRIMARY.value,
              size: ButtonSizeEnum.LARGE.value,
              padding: UiPadding.xLarge * 2,
            ),
            const SizedBox(height: UiPadding.large),
            ButtonTextWidget(
              callback: (value) => context.push(PageEnum.REGISTER.value),
              label: 'criar conta',
            ),
          ],
        ),
      ),
    );
  }
}
