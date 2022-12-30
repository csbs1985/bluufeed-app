import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/widget/input_password_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();
  final EmailService emailService = EmailService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  @override
  void initState() {
    super.initState();
    _emailController.text = 'csbs.conta@outlook.com';
    _passwordController.text = 'Csbs@002';
  }

  _login(BuildContext context) async {
    FocusScope.of(context).unfocus(); // ocultar teclado

    if (_formKey.currentState!.validate()) {
      try {
        currentEmail.value = _emailController.text;
        await _authService.login(
          context,
          _emailController.text,
          _passwordController.text,
        );
      } on Exception catch (error) {
        debugPrint('ERROR => _checkEmail: ' + error.toString());
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: UiSize.appBar),
                SvgPicture.asset(UiIcon.identity),
                const Headline1(title: 'olá de novo'),
                const Headline2(text: 'bem-vindo de volta, você fez falta!'),
                const SizedBox(height: UiPadding.xLarge),
                TextFormField(
                  controller: _emailController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      emailService.validateEmail(EmailEnum.LOGIN.value, value!),
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
                InputPasswordWidget(
                  callback: (value) => {
                    _passwordController.text = value,
                  },
                  context: context,
                  controller: _passwordController,
                  hint: 'senha',
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _login(context),
                  label: 'próximo',
                  style: ButtonStyleEnum.PRIMARY.value,
                ),
                const SizedBox(height: UiPadding.large),
                ButtonHeadline2(
                  callback: (value) => context.push(PageEnum.REGISTER.value),
                  label: 'sou novo aqui, cadastrar',
                ),
                const SizedBox(height: UiPadding.small),
                ButtonHeadline2(
                  callback: (value) =>
                      context.push(PageEnum.FORGOT_PASSWORD.value),
                  label: 'problema ao entrar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
