import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
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
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<UsuarioItemWidget> createState() => _UsuarioItemWidgetState();
}

class _UsuarioItemWidgetState extends State<UsuarioItemWidget> {
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  Map<String, dynamic>? _usuario;

  Future<void> _definirUsuario() async {
    final doc = await _usuarioFirestore.getUsuarioId(widget._idUsuario);
    _usuario = {
      'idUsuario': widget._idUsuario,
      'nomeUsuario': doc.docs.first['nomeUsuario'],
      'avatarUsuario': doc.docs.first['avatarUsuario'],
    };
  }

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
    return FutureBuilder<void>(
      future: _definirUsuario(),
      builder: (BuildContext context, _) {
        return InkWell(
          onTap: () => context.goNamed(RouteEnum.PERFIL.value,
              pathParameters: {'idUsuario': _usuario!['idUsuario']}),
          child: Container(
            height: UiTamanho.appbar,
            padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_usuario != null)
                  AvatarWidget(avatar: _usuario!['avatarUsuario']),
                const SizedBox(width: 16),
                if (_usuario != null)
                  Expanded(child: TextoText(texto: _usuario!['nomeUsuario'])),
                const SizedBox(width: 16),
                if (_usuario != null)
                  SeguirButton(idUsuario: _usuario!['idUsuario']),
                const SizedBox(width: 0),
                if (_usuario != null)
                  ValueListenableBuilder(
                    valueListenable: currentTema,
                    builder: (BuildContext context, Brightness tema, _) {
                      bool isDark = tema == Brightness.dark;

                      return IconeButton(
                        callback: () => _abrirModal(context, _usuario!),
                        cor: isDark ? UiCor.textoEscuro : UiCor.texto,
                        icone: UiSvg.opcoes,
                      );
                    },
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
