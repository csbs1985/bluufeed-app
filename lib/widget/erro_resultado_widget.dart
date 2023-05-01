import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/theme/ui_imagem.dart';
import 'package:flutter/material.dart';

class ErroResultadoWidget extends StatelessWidget {
  const ErroResultadoWidget({
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
        children: [
          Image(
            image: const AssetImage(UiImagem.erroResultado),
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Text(
            ERRO_RESULTADO,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
