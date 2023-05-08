import 'package:bluufeed_app/class/seguindo_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeguindoButton extends StatefulWidget {
  const SeguindoButton({
    super.key,
    required Map<String, dynamic> usuario,
  }) : _usuario = usuario;

  final Map<String, dynamic> _usuario;

  @override
  State<SeguindoButton> createState() => _SeguindoButtonState();
}

class _SeguindoButtonState extends State<SeguindoButton> {
  final SeguindoClass _seguindoClass = SeguindoClass();

  final double _eixo = 24.0;

  @override
  Widget build(BuildContext context) {
    int _quantidade = widget._usuario['seguindo'].length;

    _onTap() {
      if (widget._usuario['seguindo'].length > 0) {
        context.pushNamed('seguindo',
            params: {'idUsuario': widget._usuario['idUsuario']});
      }
    }

    return InkWell(
      onTap: () => _onTap(),
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
                  width: _quantidade.toDouble() * _eixo + 18,
                  height: 32,
                  child: Stack(
                    children: List.generate(
                      widget._usuario['seguindo'].length,
                      (index) => Positioned(
                        left: index * _eixo,
                        child: AvatarWidget(
                          avatar: widget._usuario['seguindo'][index]
                              ["avatarUsuario"],
                          size: UiTamanho.avatarButton,
                        ),
                      ),
                    ).toList().reversed.toList(),
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
