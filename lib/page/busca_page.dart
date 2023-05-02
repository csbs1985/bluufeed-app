import 'package:bluufeed_app/appbar/simples_appbar.dart';
import 'package:bluufeed_app/drawer/configuracao_drawer.dart';
import 'package:flutter/material.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key});

  @override
  State<BuscarPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscarPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: SimplesAppbar(
          callback: () => scaffoldKey.currentState!.openEndDrawer()),
      endDrawer: const ConfiguracaoDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
        ),
      ),
    );
  }
}
