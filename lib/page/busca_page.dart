import 'package:algolia/algolia.dart';
import 'package:bluufeed_app/appbar/busca_appbar.dart';
import 'package:bluufeed_app/class/busca_class.dart';
import 'package:bluufeed_app/config/algolia_config.dart';
import 'package:bluufeed_app/menu/busca_menu.dart';
import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscarPage> {
  final BuscaClass _buscaClass = BuscaClass();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Algolia? algolia;
  AlgoliaQuery? algoliaQuery;
  List<AlgoliaObjectSnapshot>? _snapshotHistoria;
  List<AlgoliaObjectSnapshot>? _snapshotUsuario;

  bool isInputEmpty = true;

  @override
  initState() {
    algolia = AlgoliaConfig.algolia;
    super.initState();
  }

  void keyUp(String value) {
    setState(() => isInputEmpty = value.isEmpty ? true : false);

    _buscaClass.getHistoria(value);
    _buscaClass.getUsuario(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: BuscaAppbar(callback: (value) => keyUp(value)),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            BuscaMenu(),
          ],
        ),
      ),
    );
  }
}
