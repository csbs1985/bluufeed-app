import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universe_history_app/page/home_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/about':
      //   return PageTransition(
      //     child: const AboutPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );

      // case '/denounce':
      //   return PageTransition(
      //     child: const DenouncePage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/delete-account':
      //   return PageTransition(
      //     child: const DeleteAccountPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/justify':
      //   return PageTransition(
      //     child: const JustifyPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/history':
      //   return PageTransition(
      //     child: const HistoryPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/activities':
      //   return PageTransition(
      //     child: const ActivitiesPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/name':
      //   return PageTransition(
      //     child: const NamePage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/notification':
      //   return PageTransition(
      //     child: const NotificationPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/questions':
      //   return PageTransition(
      //     child: CommonQuestionsPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/privacy':
      //   return PageTransition(
      //     child: const PrivacyPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/settings':
      //   return PageTransition(
      //     child: const SettingsPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
      // case '/terms':
      //   return PageTransition(
      //     child: const TermsPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
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

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
