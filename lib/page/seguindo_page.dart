import 'package:algolia/algolia.dart';
import 'package:eight_app/appbar/voltar_appbar.dart';
import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/algolia_config.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/firestore/usuario_firestore.dart';
import 'package:eight_app/input/padrao_input.dart';
import 'package:eight_app/skeleton/usuario_item_skeleton.dart';
import 'package:eight_app/text/subtitulo_text.dart';
import 'package:eight_app/theme/ui_tamanho.dart';
import 'package:eight_app/widget/erro_resultado_widget.dart';
import 'package:eight_app/widget/sem_resultado_widget.dart';
import 'package:eight_app/widget/usuario_lista_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class SeguindoPage extends StatefulWidget {
  const SeguindoPage({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<SeguindoPage> createState() => _SeguindoPageState();
}

class _SeguindoPageState extends State<SeguindoPage> {
  final UsuarioClass _usuarioClass = UsuarioClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  Algolia? algoliaUsuario;

  String _texto = "";

  List<Map<String, dynamic>> _snapshotUsuario = [];

  @override
  initState() {
    algoliaUsuario = AlgoliaConfig.algoliaUsuario;
    super.initState();
  }

  void keyUp(String value) {
    setState(() {
      _texto = value;
      _snapshotUsuario = [];
    });

    if (value.length > 2) _getUsuario(value);
  }

  _getUsuario(String _usuario) async {
    if (algoliaUsuario != null) {
      AlgoliaQuery _queryUsuario =
          algoliaUsuario!.instance.index('usuarios').query(_usuario);

      AlgoliaQuerySnapshot _snapUsuario = await _queryUsuario.getObjects();

      setState(() {
        if (_usuario.isEmpty) _snapshotUsuario = [];
        if (_snapUsuario.hits.isNotEmpty) {
          _snapshotUsuario = _snapUsuario.hits
              .map((algoliaObject) => algoliaObject.data)
              .toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

    return Scaffold(
      appBar: const VoltarAppbar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: PadraoInput(
                hintText: PESQUISA,
                callback: (value) => keyUp(value),
              ),
            ),
            if (_texto.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SubtituloText(subtitulo: PESQUISA),
                  ),
                  if (_snapshotUsuario.isNotEmpty)
                    UsuarioListaWidget(usuarios: _snapshotUsuario),
                ],
              ),
            if (_texto.isEmpty)
              FirestoreListView(
                query: _usuarioFirestore.getAllSeguindo(widget._idUsuario),
                pageSize: 10,
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                loadingBuilder: (context) => const UsuarioItemSkeleton(),
                errorBuilder: (context, error, _) =>
                    ErroResultadoWidget(altura: _altura),
                emptyBuilder: (context) => SemResultadoWidget(altura: _altura),
                itemBuilder: (BuildContext context,
                    QueryDocumentSnapshot<dynamic> snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: SubtituloText(subtitulo: SEGUINDO),
                      ),
                      UsuarioListaWidget(
                          usuarios: _usuarioClass.getListaUsuarios(snapshot)),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
