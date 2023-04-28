import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
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
    scaffoldBackgroundColor: UiCor.main,
    fontFamily: 'nunito',
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiCor.main),
    // textButtonTheme: TextButtonThemeData(style: UiButton.button),
    // inputDecorationTheme: UiTextField.textField,
    textTheme: const TextTheme(
      displayLarge: UiTexto.texto2,
      displayMedium: UiTexto.texto1,
      // displaySmall: UiTexto.headline3,
      // headlineMedium: UiTexto.headline4,
      // headlineSmall: UiTexto.headline5,
      titleLarge: UiTexto.texto6,
    ),
  );

  static ThemeData temaEscuro = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.mainEscuro,
      elevation: 0,
    ),
    scaffoldBackgroundColor: UiCor.mainEscuro,
    fontFamily: 'nunito',
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiCor.mainEscuro),
    // textButtonTheme: TextButtonThemeData(style: UiButton.buttonDark),
    // inputDecorationTheme: UiTextField.textFieldDark,
    textTheme: const TextTheme(
      displayLarge: UiTextoEscuro.texto2,
      displayMedium: UiTextoEscuro.texto1,
      // displaySmall: UiTextDark.headline3,
      // headlineMedium: UiTextDark.headline4,
      // headlineSmall: UiTextDark.headline5,
      titleLarge: UiTextoEscuro.texto6,
    ),
  );
}
