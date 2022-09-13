import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universe_history_app/page/code_page.dart';
import 'package:universe_history_app/page/forgot_password_page.dart';
import 'package:universe_history_app/page/history_page.dart';
import 'package:universe_history_app/page/home_page.dart';
import 'package:universe_history_app/page/login_page.dart';
import 'package:universe_history_app/page/register_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/code':
        return PageTransition(
          child: const CodePage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/forgot_password':
        return PageTransition(
          child: const ForgotPasswordPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/history':
        return PageTransition(
          child: const HistoryPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/login':
        return PageTransition(
          child: const LoginPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/register':
        return PageTransition(
          child: const RegisterPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/':
      case '/home':
      default:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          settings: settings,
        );
    }
  }
}
