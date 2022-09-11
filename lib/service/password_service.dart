import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class PasswordService {
  final UserFirestore userFirestore = UserFirestore();
  final ToastWidget toast = ToastWidget();

  late String _toastMessage = '';

  bool validatePassword(BuildContext context, String _password) {
    _toastMessage = '';

    if (_password.isEmpty) _toastMessage = 'informe sua senha.';

    if (_toastMessage.isNotEmpty)
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        _toastMessage,
      );

    return _toastMessage.isEmpty ? true : false;
  }
}
