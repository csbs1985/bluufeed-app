import 'package:bluufeed_app/button/modal_button.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsuarioModal extends StatefulWidget {
  const UsuarioModal({
    super.key,
    required Map<String, dynamic> usuario,
  }) : _usuario = usuario;

  final Map<String, dynamic> _usuario;

  @override
  State<UsuarioModal> createState() => _UsuarioModalState();
}

class _UsuarioModalState extends State<UsuarioModal> {
  bool? isUsuario;

  @override
  void initState() {
    super.initState();
    definirUsuario();
  }

  definirUsuario() {
    setState(() {
      isUsuario = widget._usuario['idUsuario'] == currentUsuario.value.idUsuario
          ? true
          : false;
    });
  }

  editarPerfil(BuildContext context) {
    Navigator.of(context).pop();
    context.pushNamed('editar_perfil',
        params: {'idUsuario': widget._usuario['idUsuario']});
  }

  denunciarUsuario() {
    print('deunciar');
  }

  bloquearUsuario() {
    print('bloquear');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          decoration: BoxDecoration(
            color: isDark ? UiCor.mainEscuro : UiCor.main,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(UiBorda.arredondada),
              topRight: Radius.circular(UiBorda.arredondada),
            ),
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Row(
                  children: [
                    AvatarWidget(
                      avatar: widget._usuario['avatarUsuario'],
                      size: 20,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextoText(texto: widget._usuario['nomeUsuario']),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    if (isUsuario!)
                      ModalButton(
                          texto: EDITAR, callback: () => editarPerfil(context)),
                    if (!isUsuario!)
                      ModalButton(
                        texto: DENUNCIAR,
                        callback: () => denunciarUsuario(),
                      ),
                    if (!isUsuario!)
                      ModalButton(
                        texto: BLOQUEAR,
                        callback: () => bloquearUsuario(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
