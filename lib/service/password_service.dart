import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<String> currentPasswordType = ValueNotifier<String>('');

class PasswordService {
  final UserFirestore userFirestore = UserFirestore();
  final ToastWidget toast = ToastWidget();

  final String _regx =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$';

  validatePassword(String _password) {
    if (_password.isEmpty) return 'informe sua senha';
    if (_password.length < 6 || _password.length > 20)
      return 'a senha deve ter de 6 à 20 caracteres';
    if (!RegExp(_regx).hasMatch(_password))
      return 'senha informada não é válida';
    return null;
  }
}

enum PasswordTypeEnum {
  CREATE('/create'),
  EDIT('/edit'),
  LOGIN('/login');

  final String value;
  const PasswordTypeEnum(this.value);
}
