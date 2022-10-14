import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_text_widget.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/form_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/service/name_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final EmailService emailService = EmailService();
  final NameService nameService = NameService();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      try {
        currentEmail.value = _emailController.text;
        currentForm.value = FormEnum.REGISTER.value;
        currentName.value = _nameController.text;
        Navigator.pushNamed(context, PageEnum.CODE.value);
      } on Exception catch (error) {
        debugPrint('ERROR => _login: ' + error.toString());
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
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
                const Headline1(title: 'Criar conta'),
                const TextAnimationWidget(
                  text: 'espero que venha pra ficar...',
                ),
                const SizedBox(height: UiPadding.large),
                const Headline2(
                  text:
                      'Olá, vamos fazer seu cadastro. Para isso, precisamos de alguns dados pessoais. '
                      'Digite seu email e nome de usuário e veremos a disponibilidade.',
                ),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  controller: _emailController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => emailService.validateEmail(
                    EmailEnum.REGISTER.value,
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
                TextFormField(
                  controller: _nameController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.text,
                  validator: (value) => nameService.validateName(value!),
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
                  callback: (value) => _login(context),
                  label: 'próximo',
                  style: ButtonStyleEnum.PRIMARY.value,
                ),
                const SizedBox(height: UiPadding.large),
                ButtonHeadline2(
                  callback: (value) => Navigator.pop(context),
                  label: 'já tenha conta, voltar',
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
