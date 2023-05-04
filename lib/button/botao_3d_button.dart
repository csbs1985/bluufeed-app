import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';

class Botao3dButton extends StatefulWidget {
  const Botao3dButton({
    super.key,
    required Function callback,
    required String texto,
    double? largura,
    double? altura,
  })  : _callback = callback,
        _texto = texto,
        _largura = largura,
        _altura = altura;

  final Function _callback;
  final String _texto;
  final double? _largura;
  final double? _altura;

  @override
  State<Botao3dButton> createState() => _Botao3dButtonState();
}

class _Botao3dButtonState extends State<Botao3dButton> {
  bool? isDark;

  late double _position = UiTamanho.bordaBotao;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        isDark = tema == Brightness.dark;

        return GestureDetector(
          child: SizedBox(
            width: widget._largura,
            height: (widget._altura ?? UiTamanho.botao) + UiTamanho.bordaBotao,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: widget._largura,
                    height: widget._altura ?? UiTamanho.botao,
                    decoration: const BoxDecoration(
                      color: UiCor.botaoBorda,
                      borderRadius: BorderRadius.all(
                          Radius.circular(UiBorda.arredondada)),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeIn,
                  bottom: _position,
                  duration: const Duration(milliseconds: 10),
                  child: Container(
                    width: widget._largura,
                    height: widget._altura ?? UiTamanho.botao,
                    padding: const EdgeInsets.symmetric(
                      horizontal: UiEspaco.medium,
                    ),
                    decoration: const BoxDecoration(
                      color: UiCor.botao,
                      borderRadius: BorderRadius.all(
                        Radius.circular(UiBorda.arredondada),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget._texto,
                        style: UiTexto.botao,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTapUp: (_) {
            setState(() {
              _position = UiTamanho.bordaBotao;
              widget._callback(true);
            });
          },
          onTapDown: (_) {
            setState(() => _position = 0);
          },
          onTapCancel: () {
            setState(() => _position = UiTamanho.bordaBotao);
          },
        );
      },
    );
  }
}
