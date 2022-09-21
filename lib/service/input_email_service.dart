import 'package:flutter/cupertino.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class InputEmailService {
  final UserFirestore userFirestore = UserFirestore();
  final ToastWidget toast = ToastWidget();

  late String _toastMessage = '';

  final String _emailRegx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  Future<bool> validateEmail(BuildContext context, String _email) async {
    _toastMessage = '';

    if (_email.isEmpty)
      _toastMessage = 'informe seu email';
    else if (!RegExp(_emailRegx).hasMatch(_email))
      _toastMessage = 'email informado não é válido.';
    else
      await _validateEmailDb(context, _email);

    if (_toastMessage.isNotEmpty)
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        _toastMessage,
      );

    return _toastMessage.isEmpty ? true : false;
  }

  _validateEmailDb(BuildContext context, String _email) async {
    await userFirestore
        .getUserEmail(_email)
        .then((result) => {
              if (result.size <= 0)
                _toastMessage = 'email informado não cadastrato.'
            })
        .catchError((error) => debugPrint('ERROR => _checkEmailDb: $error'));
  }
}
