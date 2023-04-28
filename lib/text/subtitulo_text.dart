import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';

class SubtituloText extends StatelessWidget {
  const SubtituloText({
    super.key,
    required String subtitulo,
  }) : _subtitulo = subtitulo;

  final String _subtitulo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        _subtitulo,
        style: UiTexto.texto7,
      ),
    );
  }
}
