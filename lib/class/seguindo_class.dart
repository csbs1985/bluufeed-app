import 'package:bluufeed_app/config/constant_config.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<dynamic>> currentSeguindoLista =
    ValueNotifier<List<dynamic>>([]);

class SeguindoClass {
  String textoSeguindoButton(List<dynamic> _usuario) {
    int _quantidade = _usuario.length;

    if (_quantidade == 0) return SEGUINDO_VAZIO;
    if (_quantidade == 1) return SEGUINDO_UM;
    if (_quantidade < 5) return "$_quantidade $SEGUINDO_PESSOAS";
    int _limite = _quantidade - 5;
    return "+ $_limite $SEGUINDO_PESSOAS";
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
