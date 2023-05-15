import 'package:bluufeed_app/appbar/inicio_appbar.dart';
import 'package:bluufeed_app/button/historia_criar_button.dart';
import 'package:bluufeed_app/config/auth_config.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final AuthConfig _authConfig = AuthConfig();

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
    _authConfig.verificarHive(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(toolbarHeight: 0),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            actions: [Container()],
            toolbarHeight: UiTamanho.appbar,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: InicioAppbar(callback: _scrollToTop),
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
