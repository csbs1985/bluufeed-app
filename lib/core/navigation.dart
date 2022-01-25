import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universe_history_app/pages/about_page.dart';
import 'package:universe_history_app/pages/blocked_users_page.dart';
import 'package:universe_history_app/pages/common_questions_page.dart';
import 'package:universe_history_app/pages/create_history_page.dart';
import 'package:universe_history_app/pages/delete_account_page.dart';
import 'package:universe_history_app/pages/home_page.dart';
import 'package:universe_history_app/pages/justify_page.dart';
import 'package:universe_history_app/pages/notification_page.dart';
import 'package:universe_history_app/pages/privacy_page.dart';
import 'package:universe_history_app/pages/settings_page.dart';
import 'package:universe_history_app/pages/terms_page.dart';

class Navigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/about':
        return PageTransition(
          child: const AboutPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/blocked':
        return PageTransition(
          child: const blockedUsersPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/create':
        return PageTransition(
          child: const CreateHistory(),
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );
      case '/delete-account':
        return PageTransition(
          child: const DeleteAccountPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/justify':
        return PageTransition(
          child: const JustifyPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/notification':
        return PageTransition(
          child: const NotificationPage(),
          type: PageTransitionType.topToBottom,
          settings: settings,
        );
      case '/questions':
        return PageTransition(
          child: CommonQuestionsPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/privacy':
        return PageTransition(
          child: const PrivacyPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/settings':
        return PageTransition(
          child: const SettingsPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/terms':
        return PageTransition(
          child: const TermsPage(),
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