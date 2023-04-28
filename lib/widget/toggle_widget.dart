import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({
    super.key,
    required Function callback,
    required bool value,
  })  : _callback = callback,
        _value = value;

  final Function _callback;
  final bool _value;

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = theme == Brightness.dark;

        return FlutterSwitch(
          width: UiTamalho.toggleLargura,
          height: UiTamalho.toggleAltura,
          value: widget._value,
          activeColor: UiCor.primeiro,
          inactiveColor: isDark ? UiCor.botaoSegundoEscuro : UiCor.botaoSegundo,
          activeToggleColor: UiCor.segundo,
          inactiveToggleColor: UiCor.primeiro,
          toggleSize: UiTamalho.toggleTamanho,
          onToggle: (value) => widget._callback(value),
        );
      },
    );
  }
}
