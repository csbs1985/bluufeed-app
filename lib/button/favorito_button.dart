import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/firestore/usuario_firestore.dart';
import 'package:eight_app/text/legenda_text.dart';
import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_svg.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:eight_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoritoButton extends StatefulWidget {
  const FavoritoButton({
    super.key,
    required String idHistoria,
  }) : _idHistoria = idHistoria;

  final String _idHistoria;

  @override
  State<FavoritoButton> createState() => _FavoritoButtonState();
}

class _FavoritoButtonState extends State<FavoritoButton> {
  final ToastWidget _toastWidget = ToastWidget();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  void toggleFavorito(BuildContext context, String _idHistoria) {
    try {
      setState(() {
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
      });
    } catch (e) {
      _toastWidget.toast(context, ToastEnum.ERRO, HISTORIA_ERRO);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return InkWell(
          borderRadius: BorderRadius.circular(UiBorda.circulo),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder(
              valueListenable: currentUsuario,
              builder: (BuildContext context, UsuarioModel _usuario, _) {
                return Row(
                  children: [
                    SvgPicture.asset(
                      _usuario.favoritos.contains(widget._idHistoria)
                          ? UiSvg.favoritoAtivo
                          : UiSvg.favorito,
                      color: _usuario.favoritos.contains(widget._idHistoria)
                          ? null
                          : isDark
                              ? UiCor.textoEscuro
                              : UiCor.texto,
                    ),
                    const SizedBox(width: 8),
                    LegendaText(
                      legenda: _usuario.favoritos.contains(widget._idHistoria)
                          ? FAVORITO_DEIXAR
                          : FAVORITO,
                    ),
                  ],
                );
              },
            ),
          ),
          onTap: () => toggleFavorito(
            context,
            widget._idHistoria,
          ),
        );
      },
    );
  }
}
