import 'package:bluufeed_app/class/seguindo_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';

class SeguindoButton extends StatefulWidget {
  const SeguindoButton({
    super.key,
    required List<dynamic> usuario,
  }) : _usuario = usuario;

  final List<dynamic> _usuario;

  @override
  State<SeguindoButton> createState() => _SeguindoButtonState();
}

class _SeguindoButtonState extends State<SeguindoButton> {
  final SeguindoClass _seguindoClass = SeguindoClass();
  final UsuarioClass _usuarioClass = UsuarioClass();

  final double _eixo = 24.0;

  @override
  Widget build(BuildContext context) {
    int _quantidade = widget._usuario.length >= 5 ? 5 : widget._usuario.length;

    return InkWell(
      // onTap: () => context.pushNamed(RouteEnum.SEGUINDO.value,
      //     params: {'idUsuario': widget._usuario['idUsuario']}),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubtituloText(subtitulo: SEGUINDO),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: _quantidade.toDouble() * _eixo +
                      (_quantidade > 0 ? 18 : 0),
                  height: 32,
                  child: Stack(
                    children: List.generate(
                      widget._usuario.take(5).length,
                      (index) => Positioned(
                        left: index * _eixo,
                        // _usuarioClass.getUsuarioId(),
                        child: AvatarWidget(
                          avatar:
                              _usuarioClass.getAvatarId(widget._usuario[index]),
                          // avatar: widget._usuario['seguindo'][index]
                          //     ["avatarUsuario"],
                          size: UiTamanho.avatarButton,
                        ),
                      ),
                    ).reversed.toList(),
                  ),
                ),
                TextoText(
                    texto: _seguindoClass.textoSeguindoButton(widget._usuario))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
