import 'package:eight_app/class/atividade_class.dart';
import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/firestore/comentario_firestore.dart';
import 'package:eight_app/firestore/historia_firestore.dart';
import 'package:eight_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';

class ComentarioModel {
  late String avatarUsuario;
  late String dataRegistro;
  late String idComentario;
  late String idHistoria;
  late String idUsuario;
  late String nomeUsuario;
  late String situacaoUsuario;
  late String texto;
  late bool isAnonimo;
  late bool isDeletado;
  late bool isEditado;

  ComentarioModel({
    required this.avatarUsuario,
    required this.dataRegistro,
    required this.idComentario,
    required this.idHistoria,
    required this.idUsuario,
    required this.nomeUsuario,
    required this.situacaoUsuario,
    required this.texto,
    required this.isAnonimo,
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
    if (_historia['qtdComentario'] == 1) return COMENTARIO;
    if (_historia['qtdComentario'] > 1) return COMENTARIOS_PLURAL;
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
      tipoAtividade: AtividadeEnum.NEW_COMMENT.value,
      conteudo: _comentario['texto'],
      idConteudo: _historia['idHistoria'],
    );
    _toastWidget.toast(context, ToastEnum.SUCESSO, COMENTARIO_PUBLICADO);
  }

  pathQtdComentarioHistoria(Map<String, dynamic> _historia) async {
    await _historiaFirestore.pathQtdComentarioHistoria(_historia);
  }

  deletarTodosComentarioUsuario() async {
    await _comentarioFirestore
        .getTodosComentarioUsuario(currentUsuario.value.idUsuario)
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await _comentarioFirestore.upStatusUserComment(item['id']),
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }
}
