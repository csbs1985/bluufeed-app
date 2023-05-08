import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/skeleton/perfil_skeleton.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/perfil_item_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  Map<String, dynamic> _usuario = {};

  @override
  Widget build(BuildContext context) {
    double _altura =
        MediaQuery.of(context).size.height - (UiTamanho.appbar * 4);

    return StreamBuilder<QuerySnapshot>(
      stream: _usuarioFirestore.snapshotsUsuario(widget._idUsuario),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return SemResultadoWidget(altura: _altura);
          case ConnectionState.waiting:
            return const PerfilSkeleton();
          case ConnectionState.done:
          default:
            _usuario = UsuarioModel.toMap(snapshot.data!.docs[0]);
            return PerfilItemWidget(usuario: _usuario);
        }
      },
    );
  }
}
