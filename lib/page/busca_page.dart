import 'package:algolia/algolia.dart';
import 'package:bluufeed_app/appbar/busca_appbar.dart';
import 'package:bluufeed_app/class/busca_class.dart';
import 'package:bluufeed_app/config/algolia_config.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/menu/busca_menu.dart';
import 'package:bluufeed_app/widget/busca_lista_widget.dart';
import 'package:bluufeed_app/widget/historia_lista_busca_widget.dart';
import 'package:bluufeed_app/widget/usuario_lista_widget.dart';
import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscarPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Algolia? algoliaHistoria;
  Algolia? algoliaUsuario;
  AlgoliaQuery? algoliaQuery;
  List<AlgoliaObjectSnapshot> _snapshotHistoria = [];
  List<AlgoliaObjectSnapshot> _snapshotUsuario = [];

  String _texto = "";
  String _busca = BuscaEnum.HISTORIA.value;

  @override
  initState() {
    algoliaHistoria = AlgoliaConfig.algoliaHistoria;
    algoliaUsuario = AlgoliaConfig.algoliaUsuario;
    super.initState();
  }

  void keyUp(String value) {
    setState(() {
      _texto = value;
      _snapshotHistoria = _snapshotUsuario = [];
    });

    if (value.length > 2) {
      _getHistoria(value);
      _getUsuario(value);
      _snapshotHistoria.isEmpty && _snapshotUsuario.isEmpty;
    }
  }

  _getHistoria(String _historia) async {
    if (algoliaHistoria != null) {
      AlgoliaQuery _queryHistoria =
          algoliaHistoria!.instance.index('historias').query(_historia);

      AlgoliaQuerySnapshot _snapHistoria = await _queryHistoria.getObjects();

      if (_snapHistoria.hits.isNotEmpty) _snapshotHistoria = _snapHistoria.hits;
      if (_historia.isEmpty) _snapshotHistoria = [];
    }
  }

  _getUsuario(String _usuario) async {
    if (algoliaUsuario != null) {
      AlgoliaQuery _queryUsuario =
          algoliaUsuario!.instance.index('usuarios').query(_usuario);

      AlgoliaQuerySnapshot _snapUsuario = await _queryUsuario.getObjects();

      if (_snapUsuario.hits.isNotEmpty) _snapshotUsuario = _snapUsuario.hits;
      if (_usuario.isEmpty) _snapshotUsuario = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: BuscaAppbar(callback: (value) => keyUp(value)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_texto.isEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text(
                  BUSCA_VAZIA,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            if (_texto.isNotEmpty)
              BuscaMenu(callback: (value) => setState(() => _busca = value)),
            if (_texto.isEmpty) const BuscaListaWidget(),
            if (_busca == BuscaEnum.USUARIO.value)
              UsuarioListaWidget(snapshot: _snapshotUsuario),
            if (_busca == BuscaEnum.HISTORIA.value)
              HistoriaListaBuscaWidget(snapshot: _snapshotHistoria),
          ],
        ),
      ),
    );
  }
}
