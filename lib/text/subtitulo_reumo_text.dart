import 'package:bluufeed_app/text/resumo_text.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubtituloResumoText extends StatelessWidget {
  const SubtituloResumoText({
    super.key,
    required String subtitulo,
    required String resumo,
  })  : _subtitulo = subtitulo,
        _resumo = resumo;

  final String _subtitulo;
  final String _resumo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtituloText(subtitulo: _subtitulo),
        const SizedBox(height: 8),
        ResumoText(resumo: _resumo),
      ],
    );
  }
}
