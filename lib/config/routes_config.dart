import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/page/entrar_page.dart';
import 'package:go_router/go_router.dart';

final RotasClass _rotasClass = RotasClass();

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          _rotasClass.buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const EntrarPage(),
      ),
    ),
    GoRoute(
      path: RouteEnum.ENTRAR.value,
      pageBuilder: (context, state) =>
          _rotasClass.buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const EntrarPage(),
      ),
    ),
    GoRoute(
      path: RouteEnum.INICIO.value,
      pageBuilder: (context, state) =>
          _rotasClass.buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const EntrarPage(),
      ),
    ),
  ],
);
