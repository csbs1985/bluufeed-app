import 'package:bluufeed_app/class/auth_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/page/busca_page.dart';
import 'package:bluufeed_app/page/entrar_page.dart';
import 'package:bluufeed_app/page/historia_page.dart';
import 'package:bluufeed_app/page/inicio_page.dart';
import 'package:go_router/go_router.dart';

final AuthClass _authClass = AuthClass();
// final UsuarioHive _usuarioHive = UsuarioHive();

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouteEnum.INICIO.value,
  refreshListenable: _authClass,
  redirect: (context, state) {
    final isAuthenticated = _authClass.isAuthenticated;
    final isLoginRoute = state.subloc == RouteEnum.ENTRAR.value;

    // if (_usuarioHive.verificarUsuario()) return RouteEnum.INICIO.value;
    if (!isAuthenticated) return isLoginRoute ? null : RouteEnum.ENTRAR.value;
    if (isLoginRoute) return RouteEnum.INICIO.value;
    return null;
  },
  routes: [
    GoRoute(
      path: RouteEnum.BUSCAR.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const BuscarPage(),
      ),
    ),
    GoRoute(
      path: RouteEnum.ENTRAR.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const EntrarPage(),
      ),
    ),
    GoRoute(
      path: RouteEnum.INICIO.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const InicioPage(),
      ),
    ),
    GoRoute(
      path: RouteEnum.HISTORIA.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const HistoriaPage(),
      ),
    ),
  ],
);
