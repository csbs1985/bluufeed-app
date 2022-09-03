import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/core/routes.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final UserClass _userClass = UserClass();
  final UsersFirestore _usersFirestore = UsersFirestore();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    UiTheme.setTheme;
    identify;
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

  void identify() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        try {
          await _userClass.readUser();
          await _usersFirestore.getUserEmail(user.email).then(
                (result) => _userClass.add(
                  {
                    'id': result.docs[0]['id'],
                    'date': result.docs[0]['date'],
                    'name': result.docs[0]['name'],
                    'upDateName': result.docs[0]['upDateName'],
                    'status': result.docs[0]['status'],
                    'email': result.docs[0]['email'],
                    'token': result.docs[0]['token'],
                    'isNotification': result.docs[0]['isNotification'],
                    'qtyHistory': result.docs[0]['qtyHistory'],
                    'qtyComment': result.docs[0]['qtyComment'],
                  },
                ),
              );
        } on AuthException catch (error) {
          debugPrint('ERROR => getUserEmail: $error');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          bool isDark = currentTheme.value == Brightness.dark;

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationParser: routes.routeInformationParser,
            routeInformationProvider: routes.routeInformationProvider,
            routerDelegate: routes.routerDelegate,
            theme: isDark ? UiTheme.themeDark : UiTheme.theme,
          );
        },
      ),
    );
  }
}
