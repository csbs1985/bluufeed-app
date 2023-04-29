import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/firestore/historia_firebase.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';

final HistoriaFirestore _historiaFirestore = HistoriaFirestore();
final ToastWidget _toastWidget = ToastWidget();
final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

class FavoritoModel {
  late String idUsuario;

  FavoritoModel({
    required this.idUsuario,
  });
}

class FavoritoClass {
  String isFavorito(Map<String, dynamic> historia) {
    return historia['favoritos'].contains(currentUsuario.value.idUsuario)
        ? UiSvg.favoritoAtivo
        : UiSvg.favorito;
  }

  void toggleFavorito(BuildContext context, Map<String, dynamic> historia) {
    try {
      if (historia['favoritos'].contains(currentUsuario.value.idUsuario)) {
        historia['favoritos'].remove(currentUsuario.value.idUsuario);
        currentUsuario.value.qtdFavoritos--;
        _toastWidget.toast(context, ToastEnum.SUCESSO, HISTORIA_DESFAVORITADA);
      } else {
        historia['favoritos'].add(currentUsuario.value.idUsuario);
        currentUsuario.value.qtdFavoritos++;
        _toastWidget.toast(context, ToastEnum.SUCESSO, HISTORIA_FAVORITADA);
      }

      _historiaFirestore.pathFavorito(historia);
      _usuarioFirestore.pathQtdFavoritos(currentUsuario.value);
    } on Exception {
      // TODO:
    }
  }
}
