// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:universe_history_app/core/route.dart';
import 'package:universe_history_app/pages/splash_page.dart';
import 'package:universe_history_app/services/local_notification_service.dart';
import 'package:universe_history_app/services/push_notification_service.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider<LocalNotificationService>(
            create: (context) => LocalNotificationService()),
        Provider<PushNotificationService>(
          create: (context) =>
              PushNotificationService(context.read<LocalNotificationService>()),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: UiTheme.tema,
      builder: (BuildContext context, Brightness tema, __) {
        return MaterialApp(
            navigatorKey: NavigationService.navigationKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: tema),
            onGenerateRoute: Routes.generateRoute,
            home: const SplashPage());
      },
    );
  }
}
