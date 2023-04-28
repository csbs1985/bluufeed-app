import 'package:bluufeed_app/text/subtitulo_reumo_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/widget/toggle_widget.dart';
import 'package:flutter/material.dart';

class ToggleSelecionarWidget extends StatefulWidget {
  const ToggleSelecionarWidget({
    super.key,
    required Function callback,
    required String titulo,
    required String resumo,
    required bool value,
  })  : _titulo = titulo,
        _resumo = resumo,
        _callback = callback,
        _value = value;

  final Function _callback;
  final String _titulo;
  final String _resumo;
  final bool _value;

  @override
  State<ToggleSelecionarWidget> createState() => _ToggleSelecionarWidgetState();
}

class _ToggleSelecionarWidgetState extends State<ToggleSelecionarWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget._callback(true),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.quadrada),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child: SubtituloResumoText(
              subtitulo: widget._titulo,
              resumo: widget._resumo,
            ),
          ),
          ToggleWidget(
            value: widget._value,
            callback: (value) => widget._callback(value),
          ),
        ],
      ),
    );
  }
}
