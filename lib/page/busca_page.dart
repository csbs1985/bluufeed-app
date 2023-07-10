import 'package:algolia/algolia.dart';
import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/class/busca_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/algolia_config.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/hive/busca_hive.dart';
import 'package:bluufeed_app/input/padrao_input.dart';
import 'package:bluufeed_app/menu/busca_menu.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/busca_lista_widget.dart';
import 'package:bluufeed_app/widget/historia_lista_busca_widget.dart';
import 'package:bluufeed_app/widget/pesquisar_widget.dart';
import 'package:bluufeed_app/widget/usuario_lista_widget.dart';
import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscarPage> {
  final BuscaHive _buscaHive = BuscaHive();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UsuarioClass _usuarioClass = UsuarioClass();

  Algolia? algoliaHistoria;
  Algolia? algoliaUsuario;

  List<AlgoliaObjectSnapshot> _snapshotHistoria = [];
  List<AlgoliaObjectSnapshot> _snapshotUsuario = [];

  String _texto = "";
  String _busca = BuscaEnum.HISTORIA.value;
  List<dynamic> _hive = [];

  @override
  initState() {
    algoliaHistoria = AlgoliaConfig.algoliaHistoria;
    algoliaUsuario = AlgoliaConfig.algoliaUsuario;
    _hive = _buscaHive.listaBusca();
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
    double _altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

    return Scaffold(
      key: scaffoldKey,
      appBar: const VoltarAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: PadraoInput(
              callback: (value) => keyUp(value),
              hintText: BUSCA_ESCREVER,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_texto.isEmpty && _hive.isEmpty)
                    PesquisarWidget(altura: _altura),
                  if (_texto.isEmpty && _hive.isNotEmpty)
                    BuscaMenu(
                        callback: (value) => setState(() => _busca = value)),
                  if (_texto.isEmpty) const BuscaListaWidget(),
                  if (_busca == BuscaEnum.USUARIO.value)
                    UsuarioListaWidget(
                        usuarios: _usuarioClass.algoliaToMap(_snapshotUsuario)),
                  if (_busca == BuscaEnum.HISTORIA.value)
                    HistoriaListaBuscaWidget(snapshot: _snapshotHistoria),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
