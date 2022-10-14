import 'package:flutter/cupertino.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';

ValueNotifier<String> currentName = ValueNotifier<String>('');

class NameService {
  final UserFirestore _userFirestore = UserFirestore();

  final String _regx = r'[a-z0-9-_.]';

  bool alreadyName = false;

  validateName(String value) {
    if (value.isEmpty) return 'informe um nome de usuário';
    if (value.length < 6 || value.length > 20)
      return 'deve ter de 6 à 20 caracteres';
    if (!RegExp(_regx).hasMatch(value)) return 'node de usuário não é válido';
    if (getName(value)) return 'email informado indisponivél';

    return null;
  }

  getName(String value) {
    _userFirestore
        .getName(value)
        .then(
          (result) => alreadyName = result.size > 0 ? true : false,
        )
        .catchError((error) => debugPrint('ERROR => getName: ' + error));

    return alreadyName;
  }

  nameChange(String _name, String _now) {
    _userFirestore
        .pathName(_name, _now)
        .catchError((error) => debugPrint('ERROR: ' + error));
  }
}
