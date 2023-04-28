import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/modal_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:flutter/material.dart';

class ComentarioModel {
  late String dataCriacao;
  late String idComentario;
  late String idHistoria;
  late String idUsuario;
  late String nomeUsuario;
  late String situacaoUsuario;
  late String texto;
  late bool isAssinada;
  late bool isDeletada;
  late bool isEdita;

  ComentarioModel({
    required this.dataCriacao,
    required this.idComentario,
    required this.idHistoria,
    required this.idUsuario,
    required this.nomeUsuario,
    required this.situacaoUsuario,
    required this.texto,
    required this.isAssinada,
    required this.isDeletada,
    required this.isEdita,
  });
}

final HistoriaClass _historiaClass = HistoriaClass();
final ModalClass _modalClass = ModalClass();

class ComentarioClass {
  void abrirComentario(
      BuildContext context, String _route, Map<String, dynamic> _historia) {
    if (_route != RouteEnum.HISTORIA.value && _historia['isComment']) {
      _historiaClass.adicionar(_historia);
      // _modalClass.abrirModal(context, const ComentarioModal());
    }
  }
}
