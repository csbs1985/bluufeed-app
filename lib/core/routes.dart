import 'package:go_router/go_router.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/page/create_page.dart';
import 'package:universe_history_app/page/home_page.dart';
import 'package:universe_history_app/page/login_page.dart';
import 'package:universe_history_app/page/notification_page.dart';
import 'package:universe_history_app/page/register_page.dart';
import 'package:universe_history_app/page/settings_page.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: PageEnum.CREATE.value,
      builder: (context, state) => const CreatePage(),
    ),
    GoRoute(
      path: PageEnum.HOME.value,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: PageEnum.LOGIN.value,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: PageEnum.NOTIFICATION.value,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: PageEnum.REGISTER.value,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: PageEnum.SETTINGS.value,
      builder: (context, state) => const NotificationPage(),
    )
  ],
);

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

      // case '/terms':
      //   return PageTransition(
      //     child: const TermsPage(),
      //     type: PageTransitionType.rightToLeft,
      //     settings: settings,
      //   );
