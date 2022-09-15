import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/page/code_page.dart';
import 'package:universe_history_app/page/forgot_password_page.dart';
import 'package:universe_history_app/page/home_page.dart';
import 'package:universe_history_app/page/password_create_page.dart';
import 'package:universe_history_app/page/password_page.dart';
import 'package:universe_history_app/page/register_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == PageEnum.CODE.value) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        settings: settings,
        child: const CodePage(),
      );
    }
    if (settings.name == PageEnum.FORGOT_PASSWORD.value) {
      // '/forgot_password':
      return PageTransition(
        child: const ForgotPasswordPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.PASSWORD.value) {
      return PageTransition(
        child: const PasswordPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.PASSWORD_CREATE.value) {
      return PageTransition(
        child: const PasswordCreatePage(),
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
