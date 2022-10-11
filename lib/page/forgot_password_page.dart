import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/form_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final EmailService _emailService = EmailService();
  final TextEditingController _valueController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserFirestore _userFirestore = UserFirestore();

  _validateValue(String? value) {
    if (value!.isEmpty) return 'favor insira seu email ou nome de usuário';
    return null;
  }

  _retrieveAccount() {
    if (_formKey.currentState!.validate()) {
      try {
        _getEmail();
      } on Exception catch (error) {
        debugPrint('ERROR => _checkEmail: ' + error.toString());
      }
    }
  }

  _getEmail() async {
    await _userFirestore
        .getUserEmail(_valueController.text)
        .then((result) => {
              if (result.size > 0)
                {
                  toast.toast(
                    context,
                    ToastEnum.SUCCESS.value,
                    'pronto, enviamos uma senha temporária para seu email cadastrado',
                  ),
                  currentEmail.value = _valueController.text,
                  currentForm.value = FormEnum.FORGOT.value,
                  Navigator.pushNamed(context, PageEnum.CODE.value),
                }
              else
                _getName(),
            })
        .catchError((error) => debugPrint('ERROR => _getEmail: ' + error));
  }

  _getName() async {
    await _userFirestore
        .getName(_valueController.text)
        .then(
          (result) async => {
            if (result.size > 0)
              {
                await _sendEmail(result.docs[0]['email']),
                toast.toast(
                  context,
                  ToastEnum.SUCCESS.value,
                  'pronto, enviamos uma mensagem para seu email cadastrado',
                ),
                Navigator.pushNamed(context, PageEnum.LOGIN.value),
              }
            else
              toast.toast(
                context,
                ToastEnum.WARNING.value,
                'hum, não conseguimos identifica-ló',
              ),
          },
        )
        .catchError((error) => debugPrint('ERROR => _getName: ' + error));
  }

  _sendEmail(String _email) async {
    _emailService.sendEmail(
      email: _email,
      subject: 'Recurepação de email',
      name: _valueController.text,
      code: '',
      template: EmailJsEnum.EMAIL.value,
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
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
                const Headline1(title: 'Problemas ao entrar'),
                const TextAnimationWidget(text: 'vou te ajudar...'),
                const SizedBox(height: UiPadding.large),
                const Headline2(
                  text: '- Como lembra minha senha?'
                      '\n'
                      'R: Digite seu email cadastrado no bluufeed que enviaremos um código para validação, e depois poderá alterar sua senha.'
                      '\n\n'
                      '- Como lembrar meu email cadastrado?'
                      '\n'
                      'R: Digite seu nome de usuário que enviaremos uma mensagem para o email cadastrado.'
                      '\n\n'
                      '- Não lembro meu email, senha e nome de usuário, o que faço?'
                      '\n'
                      'R: Infelizmente para nós dois não temos o que fazer para recuperar sua conta.',
                ),
                const SizedBox(height: UiPadding.large),
                TextFormField(
                  controller: _valueController,
                  style: Theme.of(context).textTheme.headline2,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => _validateValue(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: UiPadding.large,
                      vertical: UiPadding.small,
                    ),
                    hintText: 'email ou nome de usuário',
                    hintStyle: Theme.of(context).textTheme.headline2,
                  ),
                ),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _retrieveAccount(),
                  label: 'próximo',
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
