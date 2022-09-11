import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  final ToastWidget toast = ToastWidget();

  final String _emailRegx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

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
    }
    // else      _checkEmailDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Vamos criar sua conta...',
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
                hintText: 'usuário',
                hintStyle: Theme.of(context).textTheme.headline2,
              ),
            ),
            const SizedBox(height: UiPadding.large),
            Button3dWidget(
              callback: (value) => _validateEmail(context),
              label: 'criar conta',
              style: ButtonStyleEnum.PRIMARY.value,
              size: ButtonSizeEnum.LARGE.value,
              padding: UiPadding.xLarge * 2,
            ),
            const SizedBox(height: UiPadding.large),
            ButtonTextWidget(
              callback: (value) =>
                  GoRouter.of(context).push(PageEnum.LOGIN.value),
              label: 'voltar e tentar entrar',
            )
          ],
        ),
      ),
    );
  }
}
