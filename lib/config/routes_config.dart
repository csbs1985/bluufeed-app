import 'package:bluufeed_app/config/auth_config.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/page/atividade_page.dart';
import 'package:bluufeed_app/page/menu_page.dart';
import 'package:bluufeed_app/page/busca_page.dart';
import 'package:bluufeed_app/page/editar_perfil_page.dart';
import 'package:bluufeed_app/page/entrar_page.dart';
import 'package:bluufeed_app/page/historia_page.dart';
import 'package:bluufeed_app/page/inicio_page.dart';
import 'package:bluufeed_app/page/notificacao_page.dart';
import 'package:bluufeed_app/page/perfil_page.dart';
import 'package:bluufeed_app/page/politica_page.dart';
import 'package:bluufeed_app/page/seguindo_page.dart';
import 'package:bluufeed_app/page/sem_conexao_page.dart';
import 'package:bluufeed_app/page/sobre_page.dart';
import 'package:bluufeed_app/page/termo_page.dart';
import 'package:go_router/go_router.dart';

final AuthConfig _authConfig = AuthConfig();

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouteEnum.INICIO.value,
  refreshListenable: _authConfig,
  redirect: (context, state) {
    final isAuthenticated = _authConfig.isAuthenticated;
    final isLoginRoute = state.subloc == RouteEnum.ENTRAR.value;

    // if (currentUsuario.value.situacaoConta ==
    //     SituacaoUsuarioEnum.CRIANDO.value) {
    //   return context.pushNamed('editar_perfil',
    //       params: {'idUsuario': currentUsuario.value.idUsuario});
    // }
    if (!isAuthenticated) return isLoginRoute ? null : RouteEnum.ENTRAR.value;
    if (isLoginRoute) return RouteEnum.INICIO.value;

    return null;
  },
  routes: [
    GoRoute(
      name: RouteEnum.ATIVIDADE.value,
      path: '/atividade/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: AtividadePage(idUsuario: state.params['idUsuario']!),
      ),
    ),
    GoRoute(
      path: RouteEnum.BUSCAR.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const BuscarPage(),
      ),
    ),
    GoRoute(
      name: RouteEnum.EDITAR_PERFIL.value,
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
      name: RouteEnum.HISTORIA.value,
      path: '/historia/:idHistoria',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: HistoriaPage(idHistoria: state.params['idHistoria']!),
      ),
    ),
    GoRoute(
      name: RouteEnum.MENU.value,
      path: '/menu/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: MenuPage(idUsuario: state.params['idUsuario']!),
      ),
    ),
    GoRoute(
      name: RouteEnum.NOTIFICACAO.value,
      path: '/notificacao/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: NotificacaoPage(idUsuario: state.params['idUsuario']!),
      ),
    ),
    GoRoute(
      name: RouteEnum.PERFIL.value,
      path: '/perfil/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: PerfilPage(idUsuario: state.params['idUsuario']!),
      ),
    ),
    GoRoute(
      path: RouteEnum.POLITICA.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const PoliticaPage(),
      ),
    ),
    GoRoute(
      name: RouteEnum.SEGUINDO.value,
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
    GoRoute(
      path: RouteEnum.SOBRE.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const SobrePage(),
      ),
    ),
    GoRoute(
      path: RouteEnum.TERMO.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const TermoPage(),
      ),
    ),
  ],
);
