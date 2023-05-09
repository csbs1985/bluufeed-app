import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:button3d/button3d.dart';
import 'package:flutter/material.dart';

class SeguirButton extends StatefulWidget {
  const SeguirButton({
    super.key,
    required Map<String, dynamic> usuario,
    bool? tamanhoPadrao = true,
  })  : _usuario = usuario,
        _tamanhoPadrao = tamanhoPadrao;

  final Map<String, dynamic> _usuario;
  final bool? _tamanhoPadrao;

  @override
  State<SeguirButton> createState() => _SeguirButtonState();
}

class _SeguirButtonState extends State<SeguirButton> {
  final UsuarioClass _usuarioClass = UsuarioClass();

  double definirWidth() {
    double _largura = (16.0 * 2) + 60;
    return _largura;
  }

  @override
  Widget build(BuildContext context) {
    return Button3d(
      width: 100,
      height:
          widget._tamanhoPadrao! ? UiTamanho.botao : UiTamanho.botaoPrincipal,
      style: Button3dStyle(
        topColor: UiCor.botao,
        backColor: UiCor.botaoBorda,
        tappedZ: 0,
        borderRadius: BorderRadius.circular(UiBorda.arredondada),
        z: 4,
      ),
      child: Text(
        _usuarioClass.isSeguindoUsuario(widget._usuario),
        style: UiTexto.botao,
      ),
      onPressed: () => setState(() {
        _usuarioClass.toggleSeguindoUsuario(widget._usuario);
      }),
    );
  }
}
