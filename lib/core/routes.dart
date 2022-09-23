import 'package:bluuffed_app/page/about_page.dart';
import 'package:bluuffed_app/page/activity_page.dart';
import 'package:bluuffed_app/page/common_questions_page.dart';
import 'package:bluuffed_app/page/delete_account_page.dart';
import 'package:bluuffed_app/page/justify_page.dart';
import 'package:bluuffed_app/page/name_page.dart';
import 'package:bluuffed_app/page/password_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/page/code_page.dart';
import 'package:bluuffed_app/page/forgot_password_page.dart';
import 'package:bluuffed_app/page/history_page.dart';
import 'package:bluuffed_app/page/home_page.dart';
import 'package:bluuffed_app/page/login_page.dart';
import 'package:bluuffed_app/page/password_create_page.dart';
import 'package:bluuffed_app/page/password_page.dart';
import 'package:bluuffed_app/page/privacy_page.dart';
import 'package:bluuffed_app/page/register_page.dart';
import 'package:bluuffed_app/page/terms_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == PageEnum.ABOUT.value) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        settings: settings,
        child: const AboutPage(),
      );
    }
    if (settings.name == PageEnum.ACTIVITY.value) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        settings: settings,
        child: const ActivityPage(),
      );
    }
    if (settings.name == PageEnum.CODE.value) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        settings: settings,
        child: const CodePage(),
      );
    }
    if (settings.name == PageEnum.DELETE_ACCOUNT.value) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        settings: settings,
        child: const DeleteAccountPage(),
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
    if (settings.name == PageEnum.JUSTIFY.value) {
      return PageTransition(
        child: const JustifyPage(),
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
    if (settings.name == PageEnum.NAME.value) {
      return PageTransition(
        child: const NamePage(),
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
    if (settings.name == PageEnum.PASSWORD_EDIT.value) {
      return PageTransition(
        child: const PasswordEditPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.QUESTIONS.value) {
      return PageTransition(
        type: PageTransitionType.rightToLeft,
        settings: settings,
        child: CommonQuestionsPage(),
      );
    }
    if (settings.name == PageEnum.PRIVACY.value) {
      return PageTransition(
        child: const PrivacyPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    }
    if (settings.name == PageEnum.TERMS.value) {
      return PageTransition(
        child: const TermsPage(),
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
