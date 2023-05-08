import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/flutter_button.dart';

class SeguirButton extends StatefulWidget {
  const SeguirButton({
    super.key,
    required Map<String, dynamic> usuario,
  }) : _usuario = usuario;

  final Map<String, dynamic> _usuario;

  @override
  State<SeguirButton> createState() => _SeguirButtonState();
}

class _SeguirButtonState extends State<SeguirButton> {
  final UsuarioClass _usuarioClass = UsuarioClass();

  @override
  Widget build(BuildContext context) {
    // return Botao3dButton(
    //   callback: (value) => _usuarioClass.toggleSeguindoUsuario(widget._usuario),
    //   texto: _usuarioClass.isSeguindoUsuario(widget._usuario),
    //   largura: 100,
    //   altura: 28,
    // );

    return Button3D(
      onPressed: () => _usuarioClass.toggleSeguindoUsuario(widget._usuario),
      child: Text(_usuarioClass.isSeguindoUsuario(widget._usuario)),
    );
  }
}
