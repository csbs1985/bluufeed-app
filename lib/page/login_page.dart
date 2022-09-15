import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';
import 'package:universe_history_app/widget/text_animation_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  final String _regx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  _validateEmail(value) {
    if (value!.isEmpty) return 'informe seu email';
    if (!RegExp(_regx).hasMatch(_emailController.text))
      return 'email informado não é válido';
    return null;
  }

  _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await userFirestore
            .getUserEmail(_emailController.text)
            .then((result) => {
                  if (result.size > 0)
                    {
                      currentEmail.value = _emailController.text,
                      Navigator.pushNamed(context, PageEnum.CODE.value)
                    }
                  else
                    {
                      toast.toast(
                        context,
                        ToastEnum.WARNING.value,
                        'email informado não encontrado',
                      )
                    }
                })
            .catchError((error) =>
                debugPrint('ERROR => _checkEmail: ' + error.toString()));
      } on Exception catch (error) {
        debugPrint('ERROR => _checkEmail: ' + error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(UiPadding.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: UiSize.appBar),
                SvgPicture.asset(UiIcon.identity),
                const SizedBox(height: UiPadding.large),
                const TextAnimationWidget(
                    text: 'é bom ter você de volta... 😅😍'),
                const SizedBox(height: UiPadding.large),
                const TextWidget(
                    text:
                        'Informe seu email cadastrado e clique em "próximo" para continuar.'),
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
                Button3dWidget(
                  callback: (value) => _login(context),
                  label: 'próximo',
                  style: ButtonStyleEnum.PRIMARY.value,
                  size: ButtonSizeEnum.LARGE.value,
                  padding: UiPadding.large * 2,
                ),
                const SizedBox(height: UiPadding.large),
                ButtonTextWidget(
                  callback: (value) =>
                      Navigator.pushNamed(context, PageEnum.REGISTER.value),
                  label: 'sou novo aqui, cadastrar',
                ),
                ButtonTextWidget(
                  callback: (value) => Navigator.pushNamed(
                      context, PageEnum.FORGOT_PASSWORD.value),
                  label: 'preciso de ajuda',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
