import 'package:bluufeed_app/button/modal_button.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';

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
  denunciarUsuario() {}

  bloquearUsuario() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              children: [
                ModalButton(
                  texto: DENUNCIAR,
                  callback: () => denunciarUsuario(),
                ),
                ModalButton(
                  texto: BLOQUEAR,
                  callback: () => bloquearUsuario,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
