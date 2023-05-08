import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/modal/usuario_modal.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SeguindoItemWidget extends StatefulWidget {
  const SeguindoItemWidget({
    super.key,
    required Map<String, dynamic> seguindo,
  }) : _seguindo = seguindo;

  final Map<String, dynamic> _seguindo;

  @override
  State<SeguindoItemWidget> createState() => _SeguindoItemWidgetState();
}

class _SeguindoItemWidgetState extends State<SeguindoItemWidget> {
  void _abrirModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) => UsuarioModal(usuario: widget._seguindo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('perfil',
          params: {'idUsuario': widget._seguindo['idUsuario']}),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarWidget(
              avatar: widget._seguindo['avatarUsuario'],
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(child: TextoText(texto: widget._seguindo['nomeUsuario'])),
            const SizedBox(width: 16),
            SeguirButton(usuario: widget._seguindo),
            const SizedBox(width: 0),
            IconeButton(
              callback: () => _abrirModal(context),
              icone: UiSvg.opcoes,
            )
          ],
        ),
      ),
    );
  }
}
