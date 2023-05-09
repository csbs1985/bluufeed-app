import 'package:bluufeed_app/config/auth_config.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/config/conection_config.dart';
import 'package:bluufeed_app/page/busca_page.dart';
import 'package:bluufeed_app/page/editar_perfil_page.dart';
import 'package:bluufeed_app/page/entrar_page.dart';
import 'package:bluufeed_app/page/historia_page.dart';
import 'package:bluufeed_app/page/inicio_page.dart';
import 'package:bluufeed_app/page/perfil_page.dart';
import 'package:bluufeed_app/page/seguindo_page.dart';
import 'package:bluufeed_app/page/sem_conexao_page.dart';
import 'package:go_router/go_router.dart';

final AuthConfig _authConfig = AuthConfig();
final ConnectionConfig _connectionConfig = ConnectionConfig();

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouteEnum.INICIO.value,
  refreshListenable: _authConfig,
  redirect: (context, state) {
    final isConnected = _connectionConfig.isConnected;
    final isAuthenticated = _authConfig.isAuthenticated;
    final isLoginRoute = state.subloc == RouteEnum.ENTRAR.value;

    // if (!isConnected) return RouteEnum.SEM_CONEXAO.value;
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
      name: 'editar_perfil',
      path: '/editar_perfil/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: EditarPerfilPage(idUsuario: state.params['idUsuario']!),
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
      name: 'historia',
      path: '/historia/:idHistoria',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: HistoriaPage(idHistoria: state.params['idHistoria']!),
      ),
    ),
    GoRoute(
      name: 'perfil',
      path: '/perfil/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: PerfilPage(idUsuario: state.params['idUsuario']!),
      ),
    ),
    GoRoute(
      name: 'seguindo',
      path: '/seguindo/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: SeguindoPage(idUsuario: state.params['idUsuario']!),
      ),
    ),
    GoRoute(
      path: RouteEnum.SEM_CONEXAO.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const SemConexaoPage(),
      ),
    ),
  ],
);
