import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';

final ToastWidget _toastWidget = ToastWidget();
final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

class FavoritoModel {
  late String idUsuario;

  FavoritoModel({
    required this.idUsuario,
  });
}

class FavoritoClass {
  String isFavoritoIcon(String _idHistoria) {
    return currentUsuario.value.favoritos.contains(_idHistoria)
        ? UiSvg.favoritoAtivo
        : UiSvg.favorito;
  }

  void toggleFavorito(BuildContext context, String _idHistoria) {
    try {
      if (currentUsuario.value.favoritos.contains(_idHistoria)) {
        currentUsuario.value.favoritos.remove(_idHistoria);
        if (currentUsuario.value.qtdFavoritos > 0)
          currentUsuario.value.qtdFavoritos--;
      } else {
        currentUsuario.value.favoritos.add(_idHistoria);
        currentUsuario.value.qtdFavoritos++;
      }

      _usuarioFirestore.pathFavorito(currentUsuario.value.favoritos);
      _usuarioFirestore.pathQtdFavoritos(currentUsuario.value);
    } catch (e) {
      _toastWidget.toast(context, ToastEnum.ERRO, HISTORIA_ERRO);
    }
  }
}
