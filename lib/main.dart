import 'package:flutter/material.dart';
import 'package:universe_history_app/pages/home_page.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    UiTheme.setTheme();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    UiTheme.setTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDark ? UiTheme.themeDark : UiTheme.theme,
          home: const HomePage(),
        );
      },
    );
  }
}
