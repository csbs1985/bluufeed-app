import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';

ValueNotifier<String> currentName = ValueNotifier<String>('');

class NameClass {
  final String _regx = r'[a-z0-9-_.]';
  final UserFirestore _userFirestore = UserFirestore();

  late bool alreadyName;

  validateName(value) {
    if (value!.isEmpty) return 'informe seu nome de usuário';
    if (!RegExp(_regx).hasMatch(value)) return 'node de usuário não é válido';
    return null;
  }

  getName(value) async {
    await _userFirestore
        .getName(value)
        .then((result) => {
              alreadyName = result.size > 0 ? true : false,
            })
        .catchError((error) => debugPrint('ERROR => getName: ' + error));

    return alreadyName;
  }
}
