import 'package:bluufeed_app/text/subtitulo_reumo_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/toggle_widget.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required Function callback,
    required String subtitulo,
    required String resumo,
    required bool value,
  })  : _subtitulo = subtitulo,
        _resumo = resumo,
        _callback = callback,
        _value = value;

  final Function _callback;
  final String _subtitulo;
  final String _resumo;
  final bool _value;

  @override
  State<ToggleButton> createState() => _ToggleSelecionarWidgetState();
}

class _ToggleSelecionarWidgetState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: GestureDetector(
            onTap: () => widget._callback(true),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
                color: isDark ? UiCor.elementoEscura : UiCor.elemento,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SubtituloResumoText(
                      subtitulo: widget._subtitulo,
                      resumo: widget._resumo,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ToggleWidget(
                    value: widget._value,
                    callback: (value) => widget._callback(value),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
