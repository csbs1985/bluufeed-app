import 'dart:io';
import 'package:bluufeed_app/page/entrar_page.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    UiTema.definirTema();
    super.initState;
  }

  @override
  void didChangePlatformBrightness() {
    UiTema.definirTema();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: ValueListenableBuilder(
        valueListenable: UiTema.currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isEscuro = tema == Brightness.dark;

          return MaterialApp(
            home: const EntrarPage(),
            title: "Bluufeed",
            debugShowCheckedModeBanner: false,
            theme: isEscuro ? UiTema.temaEscuro : UiTema.tema,
          );
        },

        // return MaterialApp.router(
        //   routerDelegate: routes.routerDelegate,
        //   routeInformationParser: routes.routeInformationParser,
        //   routeInformationProvider: routes.routeInformationProvider,
        //   debugShowCheckedModeBanner: false,
        //   theme: isDark ? UiTema.themeDark : UiTema.theme,
        // );
      ),
    );
  }
}
