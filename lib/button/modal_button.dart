import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:flutter/material.dart';

class ModalButton extends StatefulWidget {
  const ModalButton({
    super.key,
    required String texto,
    required Function callback,
  })  : _texto = texto,
        _callback = callback;

  final String _texto;
  final Function _callback;

  @override
  State<ModalButton> createState() => _ModalButtonState();
}

class _ModalButtonState extends State<ModalButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: UiTamanho.appbar,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: InkWell(
          child: TextoText(texto: widget._texto),
          onTap: () => widget._callback(),
        ),
      ),
    );
  }
}
