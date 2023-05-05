import 'package:bluufeed_app/button/botao_3d_button.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:flutter/material.dart';

class SeguirButton extends StatefulWidget {
  const SeguirButton({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<SeguirButton> createState() => _SeguirButtonState();
}

class _SeguirButtonState extends State<SeguirButton> {
  final UsuarioClass _usuarioClass = UsuarioClass();

  @override
  Widget build(BuildContext context) {
    return Botao3dButton(
      callback: (value) =>
          _usuarioClass.toggleSeguindoUsuario(widget._idUsuario),
      texto: _usuarioClass.isSeguindoUsuario(widget._idUsuario),
      largura: 100,
      altura: 28,
    );
  }
}
