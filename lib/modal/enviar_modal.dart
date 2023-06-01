import 'package:algolia/algolia.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/algolia_config.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/input/padrao_input.dart';
import 'package:bluufeed_app/skeleton/usuario_item_skeleton.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/erro_resultado_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:bluufeed_app/widget/usuario_lista_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class EnviarModal extends StatefulWidget {
  const EnviarModal({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<EnviarModal> createState() => _EnviarModalState();
}

class _EnviarModalState extends State<EnviarModal> {
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
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            TextoText(
                texto:
                    "$ENVIAR_HISTORIA \"${widget._historia['titulo']}\" para"),
            const SizedBox(height: 16),
            PadraoInput(
              hintText: PESQUISA,
              callback: (value) => keyUp(value),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SubtituloText(subtitulo: ENVIAR),
            ),
            if (_texto.isNotEmpty)
              UsuarioListaWidget(usuarios: _snapshotUsuario),
            if (_texto.isEmpty)
              FirestoreListView(
                query: _usuarioFirestore
                    .getAllSeguindo(widget._historia['idUsuario']),
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
                  return UsuarioListaWidget(
                      usuarios: _usuarioClass.getListaUsuarios(snapshot));
                },
              ),
          ],
        ),
      ),
    );
  }
}
