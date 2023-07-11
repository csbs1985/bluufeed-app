import 'package:eight_app/text/subtitulo_reumo_text.dart';
import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    Key? key,
    required this.callback,
    this.resumo,
    this.subtitulo,
  }) : super(key: key);

  final Function callback;
  final String? subtitulo;
  final String? resumo;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.callback();
      },
      onTapCancel: () {
        setState(() => isPressed = false);
      },
      child: ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isDark = tema == Brightness.dark;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorda.arredondada),
              border: Border.all(
                color: isDark ? UiCor.elementoEscura : UiCor.elemento,
                width: 2.0,
              ),
              color: isPressed
                  ? isDark
                      ? UiCor.mainEscuro
                      : UiCor.main
                  : (isDark ? UiCor.elementoEscura : UiCor.elemento),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
