import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ValueNotifier<Brightness> currentTema = ValueNotifier(Brightness.light);

class UiTema {
  static definirTema() {
    currentTema.value =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    trocarTema();
  }

  static trocarTema() {
    bool isEscuro = currentTema.value == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isEscuro ? Brightness.light : Brightness.dark,
        statusBarBrightness: isEscuro ? Brightness.light : Brightness.dark,
        statusBarColor: isEscuro ? UiCor.mainEscuro : UiCor.main,
        systemNavigationBarIconBrightness:
            isEscuro ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isEscuro ? UiCor.mainEscuro : UiCor.main,
      ),
    );

    ThemeData();
  }

  static ThemeData tema = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.main,
      elevation: 0,
    ),
    brightness: Brightness.light,
    fontFamily: 'nunito',
    scaffoldBackgroundColor: UiCor.main,
    textTheme: const TextTheme(
      displayLarge: UiTexto.texto2,
      displayMedium: UiTexto.texto1,
      headlineMedium: UiTexto.texto4,
      headlineSmall: UiTexto.texto3,
      titleLarge: UiTexto.texto6,
      bodySmall: UiTexto.hint,
    ),
  );

  static ThemeData temaEscuro = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.mainEscuro,
      elevation: 0,
    ),
    brightness: Brightness.dark,
    fontFamily: 'nunito',
    scaffoldBackgroundColor: UiCor.mainEscuro,
    textTheme: const TextTheme(
      displayLarge: UiTextoEscuro.texto2,
      displayMedium: UiTextoEscuro.texto1,
      headlineMedium: UiTextoEscuro.texto4,
      headlineSmall: UiTextoEscuro.texto3,
      titleLarge: UiTextoEscuro.texto6,
      bodySmall: UiTextoEscuro.hintEscuro,
    ),
  );
}
