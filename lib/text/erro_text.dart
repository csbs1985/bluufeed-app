import 'package:eight_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';

class ErroText extends StatelessWidget {
  const ErroText({
    super.key,
    required String erro,
  }) : _erro = erro;

  final String _erro;

  @override
  Widget build(BuildContext context) {
    return Text(
      _erro,
      style: UiTexto.erro,
    );
  }
}
