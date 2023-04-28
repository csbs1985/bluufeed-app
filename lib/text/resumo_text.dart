import 'package:flutter/material.dart';

class ResumoText extends StatelessWidget {
  const ResumoText({
    super.key,
    required String resumo,
  }) : _resumo = resumo;

  final String _resumo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        _resumo,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
