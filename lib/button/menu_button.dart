import 'package:bluufeed_app/text/subtitulo_reumo_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/toggle_widget.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  final Function callback;
  final String? subtitulo;
  final String? resumo;
  final bool? toogle;
  final bool? value;

  const MenuButton({
    super.key,
    required this.callback,
    this.resumo,
    this.subtitulo,
    this.toogle = false,
    this.value = false,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return GestureDetector(
          onTap: () => widget.callback(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorda.arredondada),
              color: isDark ? UiCor.elementoEscura : UiCor.elemento,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SubtituloResumoText(
                    subtitulo: widget.subtitulo!,
                    resumo: widget.resumo!,
                  ),
                ),
                if (widget.toogle!) const SizedBox(width: 16),
                if (widget.toogle!)
                  ToggleWidget(
                    value: widget.value!,
                    callback: (value) => widget.callback(value),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
