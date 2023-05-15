import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';

class CorClass {
  Color definirCor(bool tema, bool _isVisualizado) {
    if (_isVisualizado) return tema ? UiCor.mainEscuro : UiCor.main;
    return tema ? UiCor.elementoEscura : UiCor.elemento;
  }
}
