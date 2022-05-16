// ignore_for_file: curly_braces_in_flow_control_structures, unused_field, constant_identifier_names, prefer_final_fields, void_checks

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/login_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Api api = Api();
  final LoginUtil loginUtil = LoginUtil();

  final emailController = TextEditingController();

  final String _regx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String _labelText = "digite seu email";

  loginLabelStyle _labelStyle = loginLabelStyle.NORMAL;
  loginButtonText _buttonText = loginButtonText.VERIFY;

  _keyUp(String _email) {
    setState(() {
      if (_email.isEmpty) {
        _labelStyle = loginLabelStyle.NORMAL;
        _labelText = "digite seu email";
      } else {
        _labelStyle = loginLabelStyle.SUCCESS;
        _labelText = "digitando email...";
      }
    });
  }

  void _verify() {
    currentLoginEmail.value = emailController.text;
    currentLoginTypeForm.value = _buttonText;

    if (_buttonText == loginButtonText.VERIFY) return _validateEmail();
    if (_buttonText == loginButtonText.REGISTER) return _register();
    if (_buttonText == loginButtonText.LOGIN) return _login();
  }

  _validateEmail() {
    setState(() {
      if (emailController.text.isEmpty) {
        _labelText = 'informe seu email';
        _labelStyle = loginLabelStyle.WARNING;
        return;
      }
      if (!RegExp(_regx).hasMatch(emailController.text)) {
        _labelText = 'email informado não é válido';
        _labelStyle = loginLabelStyle.WARNING;
        return;
      }

      _labelText = 'verificando email...';
      _labelStyle = loginLabelStyle.SUCCESS;

      api
          .getUser(emailController.text)
          .then((result) => {
                setState(() {
                  if (result.size > 0) {
                    _labelText =
                        'encontrei "${result.docs.first['nickname']}", se for você pode entrar!';
                    _labelStyle = loginLabelStyle.SUCCESS;
                    _buttonText = loginButtonText.LOGIN;
                  } else {
                    _labelText = 'email não cadastrado, criar conta!?';
                    _labelStyle = loginLabelStyle.WARNING;
                    _buttonText = loginButtonText.REGISTER;
                  }
                })
              })
          .catchError(
              (error) => debugPrint('WARNING => _checkNickIsEmpty: ' + error));
    });
  }

  _register() async {
    Navigator.pushNamed(context, '/login-nick');
  }

  _login() async {
    Navigator.pushNamed(context, '/login-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              uiPadding.large, 0, uiPadding.large, uiPadding.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent(title: 'Qual seu email?'),
              Text(_labelText, style: loginUtil.getLabelStyle(_labelStyle)),
              const SizedBox(height: uiPadding.medium),
              TextFormField(
                  autofocus: true,
                  controller: emailController,
                  onChanged: (value) => _keyUp(value),
                  style: uiTextStyle.text1,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: uiPadding.xLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button3dComponent(
                      label: loginUtil.getButtonText(_buttonText),
                      size: ButtonSizeEnum.MEDIUM,
                      style: ButtonStyleEnum.PRIMARY,
                      callback: (value) => _verify()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}