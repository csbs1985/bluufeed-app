import 'package:eight_app/config/constant_config.dart';
import 'package:flutter/material.dart';

class PesquisarWidget extends StatelessWidget {
  const PesquisarWidget({
    super.key,
    required double altura,
  }) : _altura = altura;

  final double _altura;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _altura,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Center(
        child: Text(
          BUSCA_VAZIA,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
