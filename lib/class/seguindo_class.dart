import 'package:bluufeed_app/config/constant_config.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<dynamic>> currentSeguindoLista =
    ValueNotifier<List<dynamic>>([]);

class SeguindoClass {
  String textoSeguindoButton(List<dynamic> _usuario) {
    int _quantidade = _usuario.length;

    if (_quantidade == 0) return SEGUINDO_VAZIO;
    return _quantidade == 1 ? SEGUINDO_UM : "$_quantidade $SEGUINDO_BUTTON";
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
