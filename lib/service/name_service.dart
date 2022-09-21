import 'package:flutter/cupertino.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';

ValueNotifier<String> currentName = ValueNotifier<String>('');

class NameClass {
  final String _regx = r'[a-z0-9-_.]';
  final UserFirestore _userFirestore = UserFirestore();

  late bool alreadyName;

  validateName(value) {
    if (value!.isEmpty) return 'informe seu nome de usuário';
    if (value!.length < 6 || value!.length > 20)
      return 'deve ter de 6 à 20 caracteres';
    if (!RegExp(_regx).hasMatch(value)) return 'node de usuário não é válido';
    return null;
  }

  getName(String _name) async {
    await _userFirestore
        .getName(_name)
        .then((result) => {
              alreadyName = result.size > 0 ? true : false,
            })
        .catchError((error) => debugPrint('ERROR => getName: ' + error));

    return alreadyName;
  }

  nameChange(String _name, String _now) {
    _userFirestore
        .pathName(_name, _now)
        .catchError((error) => debugPrint('ERROR: ' + error));
  }
}
