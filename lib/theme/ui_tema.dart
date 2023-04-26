import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiTema {
  static ValueNotifier<Brightness> currentTema =
      ValueNotifier(Brightness.light);

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
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiCor.main),
    fontFamily: 'nunito',
    scaffoldBackgroundColor: UiCor.main,
    // textButtonTheme: TextButtonThemeData(style: UiButton.button),
    // inputDecorationTheme: UiTextField.textField,
    textTheme: const TextTheme(
      displayLarge: UiTexto.texto1,
      // displayMedium: UiTexto.headline2,
      // displaySmall: UiTexto.headline3,
      // headlineMedium: UiTexto.headline4,
      // headlineSmall: UiTexto.headline5,
      // titleLarge: UiTexto.headline6,
    ),
  );

  static ThemeData temaEscuro = ThemeData(
    scaffoldBackgroundColor: UiCor.mainEscuro,
    fontFamily: 'nunito',
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiCor.mainEscuro),
    // textButtonTheme: TextButtonThemeData(style: UiButton.buttonDark),
    // inputDecorationTheme: UiTextField.textFieldDark,
    textTheme: const TextTheme(
      displayLarge: UiTextoEscuro.texto1,
      // displayMedium: UiTextDark.headline2,
      // displaySmall: UiTextDark.headline3,
      // headlineMedium: UiTextDark.headline4,
      // headlineSmall: UiTextDark.headline5,
      // titleLarge: UiTextDark.headline6,
    ),
  );
}
