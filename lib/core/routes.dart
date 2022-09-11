import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/page/code_page.dart';
import 'package:universe_history_app/page/forgot_password_page.dart';
import 'package:universe_history_app/page/history_page.dart';
import 'package:universe_history_app/page/home_page.dart';
import 'package:universe_history_app/page/login_page.dart';
import 'package:universe_history_app/page/register_page.dart';

class Routes {
  static Route<String> generateRoute(RouteSettings settings) {
    if (settings.name == PageEnum.CODE.value) {
      return PageTransition(
        child: const CodePage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.FORGOT_PASSWORD.value) {
      return PageTransition(
        child: const ForgotPasswordPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.HISTORY.value) {
      return PageTransition(
        child: const HistoryPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.LOGIN.value) {
      return PageTransition(
        child: const LoginPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.REGISTER.value) {
      return PageTransition(
        child: const RegisterPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    } else {
      return PageTransition(
        child: const HomePage(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    }
  }
}
