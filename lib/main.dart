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
import 'package:universe_history_app/theme/ui_color.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: UiColor.comp_1,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: UiColor.comp_1,
        systemNavigationBarIconBrightness: Brightness.light));

    return MaterialApp(
        navigatorKey: NavigationService.navigationKey,
        debugShowCheckedModeBanner: false,
        theme: UiTheme.theme1,
        onGenerateRoute: Routes.generateRoute,
        home: const SplashPage());
  }
}
