import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/modal/usuario_modal.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SeguindoItemWidget extends StatefulWidget {
  const SeguindoItemWidget({
    super.key,
    required List<dynamic> seguindo,
  }) : _seguindo = seguindo;

  final List<dynamic> _seguindo;

  @override
  State<SeguindoItemWidget> createState() => _SeguindoItemWidgetState();
}

class _SeguindoItemWidgetState extends State<SeguindoItemWidget> {
  void _abrirModal(BuildContext context, Map<String, dynamic> _usuario) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      builder: (context) => UsuarioModal(usuario: _usuario),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemCount: widget._seguindo.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => context.pushNamed('perfil',
              params: {'idUsuario': widget._seguindo[index]['idUsuario']}),
          child: Container(
            height: UiTamanho.appbar,
            padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarWidget(
                  avatar: widget._seguindo[index]['avatarUsuario'],
                  size: 20,
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: TextoText(
                        texto: widget._seguindo[index]['nomeUsuario'])),
                const SizedBox(width: 16),
                SeguirButton(usuario: widget._seguindo[index]),
                const SizedBox(width: 0),
                IconeButton(
                  callback: () => _abrirModal(context, widget._seguindo[index]),
                  icone: UiSvg.opcoes,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
