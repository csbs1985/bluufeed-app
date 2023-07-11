import 'package:eight_app/firestore/comentario_firestore.dart';
import 'package:eight_app/skeleton/comentario_skeleton.dart';
import 'package:eight_app/theme/ui_tamanho.dart';
import 'package:eight_app/widget/comentario_item_widget.dart';
import 'package:eight_app/widget/erro_resultado_widget.dart';
import 'package:eight_app/widget/sem_resultado_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class ComentarioListaWidget extends StatefulWidget {
  const ComentarioListaWidget({
    super.key,
    required String idHistoria,
  }) : _idHistoria = idHistoria;

  final String _idHistoria;

  @override
  State<ComentarioListaWidget> createState() => _ComentarioListaWidgetState();
}

class _ComentarioListaWidgetState extends State<ComentarioListaWidget> {
  final ComentarioFirestore _comentarioFirestore = ComentarioFirestore();

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FirestoreListView(
          query: _comentarioFirestore
              .getAllComentariosHistoria(widget._idHistoria),
          pageSize: 25,
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          loadingBuilder: (context) => const ComentarioSkeleton(),
          errorBuilder: (context, error, _) =>
              ErroResultadoWidget(altura: _altura),
          emptyBuilder: (context) => SemResultadoWidget(altura: _altura),
          itemBuilder: (
            BuildContext context,
            QueryDocumentSnapshot<dynamic> snapshot,
          ) {
            return CommentItemWidget(comentario: snapshot.data());
          },
        ),
      ),
    );
  }
}
