import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:flutter/cupertino.dart';

class PasswordService {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserFirestore userFirestore = UserFirestore();
  final ToastWidget toast = ToastWidget();

  final String _regx =
      r'^(?=.*[A-Z])(?=.*[@#%^*>\$@?/[]=+])(?=.*[0-9])(?=.*[a-z]).{6,20}$';

  validatePassword(String _password) {
    if (_password.isEmpty) return 'informe sua senha';
    if (_password.length < 6 || _password.length > 20)
      return 'a senha deve ter de 6 à 20 caracteres';
    if (!RegExp(_regx).hasMatch(_password))
      return 'senha informada não é válida';
    return null;
  }

  validateForm() {
    return formKey.currentState!.validate();
  }
}
