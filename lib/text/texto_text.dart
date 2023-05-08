import 'package:flutter/material.dart';

class TextoText extends StatelessWidget {
  const TextoText({
    super.key,
    required String texto,
    TextAlign? textAlign,
  })  : _texto = texto,
        _textAlign = textAlign;

  final String _texto;
  final TextAlign? _textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      _texto,
      style: Theme.of(context).textTheme.displayMedium,
      softWrap: true,
      overflow: TextOverflow.clip,
      textAlign: _textAlign ?? TextAlign.left,
    );
  }
}
