import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/page/about_page.dart';
import 'package:bluuffed_app/page/activity_page.dart';
import 'package:bluuffed_app/page/biography_page.dart';
import 'package:bluuffed_app/page/blockeds_page.dart';
import 'package:bluuffed_app/page/code_page.dart';
import 'package:bluuffed_app/page/delete_account_page.dart';
import 'package:bluuffed_app/page/denounce_page.dart';
import 'package:bluuffed_app/page/forgot_password_page.dart';
import 'package:bluuffed_app/page/history_page.dart';
import 'package:bluuffed_app/page/home_page.dart';
import 'package:bluuffed_app/page/justify_page.dart';
import 'package:bluuffed_app/page/loading_page.dart';
import 'package:bluuffed_app/page/login_page.dart';
import 'package:bluuffed_app/page/name_page.dart';
import 'package:bluuffed_app/page/password_page.dart';
import 'package:bluuffed_app/page/perfil_page.dart';
import 'package:bluuffed_app/page/privacy_page.dart';
import 'package:bluuffed_app/page/questions_page.dart';
import 'package:bluuffed_app/page/register_page.dart';
import 'package:bluuffed_app/page/terms_page.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings,

//   }

//   static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
// }

final _authService = AuthService();

final routes = GoRouter(
  initialLocation: PageEnum.HOME.value,
  refreshListenable: _authService,
  debugLogDiagnostics: true,
  redirect: (BuildContext context, GoRouterState state) {
    if (_authService.isLoading)
      return PageEnum.LOADING.value;
    else if (_authService.user == null)
      return PageEnum.LOGIN.value;
    else
      return PageEnum.HOME.value;
  },
  routes: <RouteBase>[
    GoRoute(
      path: PageEnum.HOME.value,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: PageEnum.ABOUT.value,
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: PageEnum.ACTIVITY.value,
      builder: (context, state) => const ActivityPage(),
    ),
    GoRoute(
      path: PageEnum.BIOGRAPHY.value,
      builder: (context, state) => const BiographyPage(),
    ),
    GoRoute(
      path: PageEnum.BLOCKEDS.value,
      builder: (context, state) => const BlockedsPage(),
    ),
    GoRoute(
      path: PageEnum.CODE.value,
      builder: (context, state) => const CodePage(),
    ),
    GoRoute(
      path: PageEnum.DELETE_ACCOUNT.value,
      builder: (context, state) => const DeleteAccountPage(),
    ),
    GoRoute(
      path: PageEnum.DENOUNCE.value,
      builder: (context, state) => const DenouncePage(),
    ),
    GoRoute(
      path: PageEnum.FORGOT_PASSWORD.value,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: PageEnum.HISTORY.value,
      builder: (context, state) => const HistoryPage(),
    ),
    GoRoute(
      path: PageEnum.JUSTIFY.value,
      builder: (context, state) => const JustifyPage(),
    ),
    GoRoute(
      path: PageEnum.LOGIN.value,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: PageEnum.LOADING.value,
      builder: (context, state) => const LoadingPage(),
    ),
    GoRoute(
      path: PageEnum.NAME.value,
      builder: (context, state) => const NamePage(),
    ),
    GoRoute(
      path: PageEnum.PASSWORD.value,
      builder: (context, state) => const PasswordPage(),
    ),
    GoRoute(
      path: PageEnum.PERFIL.value,
      builder: (context, state) => const PerfilPage(),
    ),
    GoRoute(
      path: PageEnum.QUESTIONS.value,
      builder: (context, state) => QuestionsPage(),
    ),
    GoRoute(
      path: PageEnum.PRIVACY.value,
      builder: (context, state) => const PrivacyPage(),
    ),
    GoRoute(
      path: PageEnum.TERMS.value,
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: PageEnum.REGISTER.value,
      builder: (context, state) => const RegisterPage(),
    )
  ],
);
