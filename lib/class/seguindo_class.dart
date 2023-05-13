import 'package:bluufeed_app/config/constant_config.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<dynamic>> currentSeguindoLista =
    ValueNotifier<List<dynamic>>([]);

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
  String textoSeguindoButton(Map<String, dynamic> _usuario) {
    int _quantidade = _usuario['seguindo'].length;

    if (_quantidade == 0) return SEGUINDO_VAZIO;
    if (_quantidade == 1) {
      String _nomeUsuario = _usuario['seguindo'].first['nomeUsuario'];
      return "$SEGUINDO_UM $_nomeUsuario";
    } else
      return "$_quantidade $SEGUINDO_BUTTON";
  }

  pesquisarSeguindo(String value) {
    if (value.length >= 3) {
      List<dynamic> resultados = currentSeguindoLista.value
          .where((usuario) => usuario["nomeUsuario"].contains(value))
          .toList();

      return resultados;
    }
  }
}
