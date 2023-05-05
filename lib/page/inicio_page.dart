import 'package:bluufeed_app/appbar/inicio_appbar.dart';
import 'package:bluufeed_app/button/historia_criar_button.dart';
import 'package:bluufeed_app/config/auth_config.dart';
import 'package:bluufeed_app/drawer/configuracao_drawer.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/historia_lista_widget.dart';
import 'package:bluufeed_app/menu/categoria_menu.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final AuthConfig _authConfig = AuthConfig();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  signInWithGoogle(BuildContext context) async {
    await _authConfig.signIn(context);
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    signInWithGoogle(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(toolbarHeight: 0),
      endDrawer: const ConfiguracaoDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            actions: [Container()],
            toolbarHeight: UiTamanho.appbar,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: InicioAppbar(
                callbackLogo: _scrollToTop,
                callbackMais: () => scaffoldKey.currentState!.openEndDrawer(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                HistoriaCriarButton(),
                const CategoriaMenu(),
                const HistoriaListaWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
