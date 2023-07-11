import 'package:eight_app/class/texto_class.dart';
import 'package:eight_app/theme/ui_espaco.dart';
import 'package:flutter/material.dart';

class TituloText extends StatelessWidget {
  TituloText({
    super.key,
    required String titulo,
  }) : _titulo = titulo;

  final TextoClass _textoClass = TextoClass();

  final String _titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width:MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.only(bottom: UiEspaco.small),
      child: Text(
        _textoClass.capitalize(_titulo),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
