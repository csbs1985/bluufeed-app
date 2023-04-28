import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/favorito_class.dart';
import 'package:flutter/material.dart';

ValueNotifier<HistoriaModel> currentHistoria =
    ValueNotifier<HistoriaModel>(HistoriaModel(
  idHistoria: '',
  titulo: '',
  texto: '',
  dataCriacao: '',
  idUsuario: '',
  nomeUsuario: '',
  isComentario: false,
  isAssinado: false,
  isEditado: false,
  isAutorizado: false,
  qtdComentario: 0,
  categorias: [],
  favoritos: [],
));

class HistoriaModel {
  late String idHistoria;
  late String titulo;
  late String texto;
  late String dataCriacao;
  late String idUsuario;
  late String nomeUsuario;
  late bool isComentario;
  late bool isAssinado;
  late bool isEditado;
  late bool isAutorizado;
  late int qtdComentario;
  late List<CategoriaModel> categorias;
  late List<FavoritoModel> favoritos;

  HistoriaModel({
    required this.idHistoria,
    required this.titulo,
    required this.texto,
    required this.dataCriacao,
    required this.idUsuario,
    required this.nomeUsuario,
    required this.isComentario,
    required this.isAssinado,
    required this.isEditado,
    required this.isAutorizado,
    required this.qtdComentario,
    required this.categorias,
    required this.favoritos,
  });

  factory HistoriaModel.fromJson(json) => HistoriaModel.fromMap(json);

  factory HistoriaModel.fromMap(json) => HistoriaModel(
        idHistoria: json['id'],
        titulo: json['title'],
        texto: json['text'],
        dataCriacao: json['date'],
        isComentario: json['isComment'],
        isAssinado: json['isSigned'],
        isEditado: json['isEdit'],
        isAutorizado: json['isAuthorized'],
        idUsuario: json['userId'],
        nomeUsuario: json['userName'],
        qtdComentario: json['qtyComment'],
        categorias: json['categories'].cast<String>(),
        favoritos: json['categories'].cast<String>(),
      );
}

class HistoriaClass {
  limparCurrentHistoria() {
    currentHistoria.value = HistoriaModel(
      idHistoria: '',
      titulo: '',
      texto: '',
      dataCriacao: '',
      idUsuario: '',
      nomeUsuario: '',
      isComentario: false,
      isAssinado: false,
      isEditado: false,
      isAutorizado: false,
      qtdComentario: 0,
      categorias: [],
      favoritos: [],
    );
  }

  void adicionar(Map<String, dynamic> history) {
    limparCurrentHistoria();
    currentHistoria.value = HistoriaModel.fromJson(history);
  }

  String definirTextoComentario(Map<String, dynamic> _historia) {
    if (!_historia['isComment']) return 'comentário desabilitado';
    if (_historia['qtyComment'] == 1) return ' comentário';
    if (_historia['qtyComment'] > 1) return ' comentários';
    return 'seja o primeiro';
  }

  bool isComentario(String? _route, Map<String, dynamic> _historia) {
    // if (_route == RouteEnum.historia.value) return false;
    if (_historia['isComment']) return true;
    return false;
  }
}
