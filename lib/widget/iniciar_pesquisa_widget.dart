import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/text/texto_text.dart';
import 'package:flutter/material.dart';

class InicarPesquisaWidget extends StatelessWidget {
  const InicarPesquisaWidget({
    super.key,
    required double altura,
  }) : _altura = altura;

  final double _altura;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _altura,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          TextoText(
            texto: PESQUISA_INICIAR,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
