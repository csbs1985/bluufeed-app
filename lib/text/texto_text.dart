import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:flutter/material.dart';

class TextoText extends StatelessWidget {
  const TextoText({
    super.key,
    required String texto,
    int? limiteLinha,
  })  : _texto = texto,
        _limiteLinha = limiteLinha;

  final String _texto;
  final int? _limiteLinha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: UiEspaco.large),
      child: Text(
        _texto,
        maxLines: _limiteLinha,
        style: Theme.of(context).textTheme.displayMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
