import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:universe_history_app/core/routes.dart';
import 'package:universe_history_app/service/auth_check_service.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/service/local_notification_service.dart';
import 'package:universe_history_app/service/push_notification_service.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        Provider<LocalNotificationService>(
            create: (context) => LocalNotificationService()),
        Provider<PushNotificationService>(
          create: (context) =>
              PushNotificationService(context.read<LocalNotificationService>()),
        )
      ],
      child: const MyApp(),
    ),
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
    UiTheme.setTheme;
    super.initState;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    UiTheme.setTheme();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          bool isDark = currentTheme.value == Brightness.dark;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const AuthCheckService(),
            theme: isDark ? UiTheme.themeDark : UiTheme.theme,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}
