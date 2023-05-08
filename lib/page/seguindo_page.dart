import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/input/pesquisa_input.dart';
import 'package:bluufeed_app/skeleton/seguindo_skeleton.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
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
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  String? _textoPesquisa;
  final int _quantidade = 0;

  @override
  Widget build(BuildContext context) {
    double _altura =
        MediaQuery.of(context).size.height - (UiTamanho.appbar * 4);

    return Scaffold(
      appBar: const VoltarAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: PesquisaInput(callback: (value) => _textoPesquisa = value),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SubtituloText(subtitulo: SEGUINDO),
          ),
          FirestoreListView(
            query: _usuarioFirestore.getSeguindoUsuario(widget._idUsuario),
            pageSize: 10,
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            loadingBuilder: (context) => const SeguindoSkeleton(),
            errorBuilder: (context, error, _) => const SeguindoSkeleton(),
            emptyBuilder: (context) => const SeguindoSkeleton(),
            itemBuilder: (BuildContext context,
                QueryDocumentSnapshot<dynamic> snapshot) {
              return const SeguindoSkeleton();
            },
          ),
        ],
      ),
    );
  }
}
