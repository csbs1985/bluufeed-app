import 'package:bluufeed_app/class/atividade_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/firestore/comentario_firestore.dart';
import 'package:bluufeed_app/firestore/historia_firestore.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';

class ComentarioModel {
  late String avatarUsuario;
  late String dataCriacao;
  late String idComentario;
  late String idHistoria;
  late String idUsuario;
  late String nomeUsuario;
  late String situacaoUsuario;
  late String texto;
  late bool isDeletado;
  late bool isEditado;

  ComentarioModel({
    required this.avatarUsuario,
    required this.dataCriacao,
    required this.idComentario,
    required this.idHistoria,
    required this.idUsuario,
    required this.nomeUsuario,
    required this.situacaoUsuario,
    required this.texto,
    required this.isDeletado,
    required this.isEditado,
  });
}

class ComentarioClass {
  final AtividadeClass _atividadeClass = AtividadeClass();
  final ComentarioFirestore _comentarioFirestore = ComentarioFirestore();
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();
  final ToastWidget _toastWidget = ToastWidget();

  String definirTextoComentario(Map<String, dynamic> _historia) {
    if (!_historia['isComentario']) return COMENTARIOS_DESABILITADOS;
    if (_historia['qtdComentario'] == 1)
      return '${_historia['qtdComentario']} $COMENTARIO';
    if (_historia['qtdComentario'] > 1)
      return '${_historia['qtdComentario']} $COMENTARIOS_PLURAL';
    return COMENTARIOS_PRIMEIRO;
  }

  postComentario(
    BuildContext context,
    Map<String, dynamic> _comentario,
    Map<String, dynamic> _historia,
  ) async {
    await _comentarioFirestore.postComentario(_comentario);
    pathQtdComentarioHistoria(_historia);
    _atividadeClass.postAtividade(
      type: AtividadeEnum.NEW_COMMENT.value,
      content: _comentario['texto'],
      elementId: _historia['idHistoria'],
    );
    _toastWidget.toast(context, ToastEnum.SUCESSO, COMENTARIO_PUBLICADO);
  }

  pathQtdComentarioHistoria(Map<String, dynamic> _historia) async {
    await _historiaFirestore.pathQtdComentarioHistoria(_historia);
  }
}
