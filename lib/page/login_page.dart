import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/widget/app_bar_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/form_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final EmailService emailService = EmailService();
  final TextEditingController _emailController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await userFirestore
            .getUserEmail(_emailController.text)
            .then((result) => {
                  if (result.size <= 0)
                    toast.toast(
                      context,
                      ToastEnum.WARNING.value,
                      'email informado não encontrado',
                    )
                  else
                    {
                      currentEmail.value = _emailController.text,
                      currentForm.value = FormEnum.LOGIN.value,
                      Navigator.pushNamed(context, PageEnum.CODE.value)
                    }
                });
      } on Exception catch (error) {
        debugPrint('ERROR => _checkEmail: ' + error.toString());
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHomeWidget(callback: (value) {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Headline1(title: 'Entrar'),
                const TextAnimationWidget(text: 'é bom ter você de volta...'),
                const SizedBox(height: UiPadding.large),
                const Headline2(
                  text:
                      'Informe seu email cadastrado e clique em "próximo" para continuar.',
                ),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  controller: _emailController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => emailService.validateEmail(
                    EmailEnum.LOGIN.value,
                    value!,
                  ),
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
                Button3dWidget(
                  callback: (value) => _login(context),
                  label: 'próximo',
                  style: ButtonStyleEnum.PRIMARY.value,
                ),
                const SizedBox(height: UiPadding.large),
                ButtonHeadline2(
                  callback: (value) =>
                      Navigator.pushNamed(context, PageEnum.REGISTER.value),
                  label: 'sou novo aqui, cadastrar',
                ),
                ButtonHeadline2(
                  callback: (value) => Navigator.pushNamed(
                    context,
                    PageEnum.FORGOT_PASSWORD.value,
                  ),
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
