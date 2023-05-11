import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';

class EditarPerfilClass {
  final ToastWidget _toastWidget = ToastWidget();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  final String _regx = r'[a-z0-9-_.]';

  bool alreadyNome = false;

  validarNomeUsuario(String value) {
    if (value.isEmpty) return EDITAR_ERRO_VAZIO;
    if (value.length < 6 || value.length > 20) return EDITAR_ERRO_CARACTERES;
    if (!RegExp(r'[a-z0-9-_.]').hasMatch(value)) return EDITAR_ERRO_INVALIDO;
    if (getNomeUsuario(value)) return EDITAR_ERRO_INDISPONIVEL;
    return null;
  }

  getNomeUsuario(String value) {
    _usuarioFirestore
        .getNomeUsuario(value)
        .then((result) => alreadyNome = result.size > 0 ? true : false)
        .catchError((error) => print('ERROR => getNomeUsuario: ' + error));
    return alreadyNome;
  }

  //   nameChange(String _name, String _now) {
  //   _userFirestore
  //       .pathName(_name, _now)
  //       .catchError((error) => debugPrint('ERROR: ' + error));
  // }

  validarBiografia(String value) {
    if (value.length > 501) return EDITAR_ERRO_BIOGRAFIA;
    return null;
  }
}
