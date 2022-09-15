import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_text_widget.dart';
import 'package:universe_history_app/widget/input_password_widget.dart';
import 'package:universe_history_app/widget/text_animation_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await authService
          .login(context, currentEmail.value, _emailController.text)
          .then(
            (result) => Navigator.pushNamed(context, '/'),
          )
          .catchError((error) =>
              debugPrint('ERROR => _checkEmail: ' + error.toString()));
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
                    text: 'agora vem a senha... *️⃣*️⃣*️⃣🔐'),
                const SizedBox(height: UiPadding.large),
                const TextWidget(text: 'Informe sua senha.'),
                const SizedBox(height: UiPadding.large),
                InputPasswordWidget(
                    callback: (value) => _emailController.text = value),
                const SizedBox(height: UiPadding.large),
                Button3dWidget(
                  callback: (value) => _login(context),
                  label: 'entrar',
                  style: ButtonStyleEnum.PRIMARY.value,
                  size: ButtonSizeEnum.LARGE.value,
                  padding: UiPadding.large * 2,
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
