import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/modal/usuario_modal.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsuarioItemWidget extends StatefulWidget {
  const UsuarioItemWidget({
    super.key,
    required Map<String, dynamic> usuario,
  }) : _usuario = usuario;

  final Map<String, dynamic> _usuario;

  @override
  State<UsuarioItemWidget> createState() => _UsuarioItemWidgetState();
}

class _UsuarioItemWidgetState extends State<UsuarioItemWidget> {
  void _abrirModal(BuildContext context, Map<String, dynamic> _usuario) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => UsuarioModal(usuario: _usuario),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(RouteEnum.PERFIL.value,
          params: {'idUsuario': widget._usuario['idUsuario']}),
      child: Container(
        height: UiTamanho.appbar,
        padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarWidget(
              avatar: widget._usuario['avatarUsuario'],
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(child: TextoText(texto: widget._usuario['nomeUsuario'])),
            const SizedBox(width: 16),
            SeguirButton(idUsuario: widget._usuario['idUsuario']),
            const SizedBox(width: 0),
            ValueListenableBuilder(
              valueListenable: currentTema,
              builder: (BuildContext context, Brightness tema, _) {
                bool isDark = tema == Brightness.dark;

                return IconeButton(
                  callback: () => _abrirModal(context, widget._usuario),
                  cor: isDark ? UiCor.textoEscuro : UiCor.texto,
                  icone: UiSvg.opcoes,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
