import 'package:bluufeed_app/config/constants_config.dart';

class SeguindoModel {
  late String avatarUsuario;
  late String idUsuario;
  late String nomeUsuario;

  SeguindoModel({
    required this.avatarUsuario,
    required this.idUsuario,
    required this.nomeUsuario,
  });
}

class SeguindoClass {
  Map<String, dynamic> toSeguindo(Map<String, dynamic> _historia) {
    Map<String, dynamic> _usuario = {
      'avatarUsuario': _historia['avatarUsuario'],
      'idUsuario': _historia['idUsuario'],
      'nomeUsuario': _historia['nomeUsuario'],
    };

    return _usuario;
  }

  String textoSeguindoButton(Map<String, dynamic> _usuario) {
    int _quantidade = _usuario['seguindo'].length;

    if (_quantidade == 0) return SEGUINDO_VAZIO;
    if (_quantidade == 1) {
      String _nomeUsuario = _usuario['seguindo'].first['nomeUsuario'];
      return "$SEGUINDO_UM $_nomeUsuario";
    } else
      return "$_quantidade $SEGUINDO_BUTTON";
  }
}
