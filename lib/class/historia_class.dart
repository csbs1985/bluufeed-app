import 'package:flutter/material.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/firestore/historia_firebase.dart';

ValueNotifier<HistoriaModel> currentHistoria =
    ValueNotifier<HistoriaModel>(HistoriaModel(
  idHistoria: '',
  titulo: '',
  texto: '',
  dataCriacao: '',
  idUsuario: '',
  nomeUsuario: '',
  avatarUsuario: '',
  isComentario: false,
  isAnonimo: false,
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
  late String avatarUsuario;
  late bool isComentario;
  late bool isAnonimo;
  late bool isEditado;
  late bool isAutorizado;
  late int qtdComentario;
  late List<CategoriaModel> categorias;
  late List<String> favoritos;

  HistoriaModel({
    required this.idHistoria,
    required this.titulo,
    required this.texto,
    required this.dataCriacao,
    required this.idUsuario,
    required this.nomeUsuario,
    required this.avatarUsuario,
    required this.isComentario,
    required this.isAnonimo,
    required this.isEditado,
    required this.isAutorizado,
    required this.qtdComentario,
    required this.categorias,
    required this.favoritos,
  });

  static Map<String, dynamic> toMap(historia) => {
        'idHistoria': historia['idHistoria'],
        'titulo': historia['titulo'],
        'texto': historia['texto'],
        'dataCriacao': historia['dataCriacao'],
        'isComentario': historia['isComentario'],
        'isAnonimo': historia['isAnonimo'],
        'isEditado': historia['isEditado'],
        'isAutorizado': historia['isAutorizado'],
        'idUsuario': historia['idUsuario'],
        'nomeUsuario': historia['nomeUsuario'],
        'avatarUsuario': historia['avatarUsuario'],
        'qtdComentario': historia['qtdComentario'],
        'categorias': historia['categorias'].cast<String>(),
        'favoritos': historia['favoritos'].cast<String>(),
      };

  static HistoriaModel fromMap(Map<String, dynamic> map) {
    return HistoriaModel(
      idHistoria: map['idHistoria'],
      titulo: map['titulo'],
      texto: map['texto'],
      dataCriacao: map['dataCriacao'],
      idUsuario: map['idUsuario'],
      nomeUsuario: map['nomeUsuario'],
      avatarUsuario: map['avatarUsuario'],
      isComentario: map['isComentario'],
      isAnonimo: map['isAnonimo'],
      isEditado: map['isEditado'],
      isAutorizado: map['isAutorizado'],
      qtdComentario: map['qtdComentario'],
      categorias: map['categorias'].cast<CategoriaModel>(),
      favoritos: map['favoritos'].cast<String>(),
    );
  }
}

class HistoriaClass {
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();

  limparCurrentHistoria() {
    currentHistoria.value = HistoriaModel(
      idHistoria: '',
      titulo: '',
      texto: '',
      dataCriacao: '',
      idUsuario: '',
      nomeUsuario: '',
      avatarUsuario: '',
      isComentario: false,
      isAnonimo: false,
      isEditado: false,
      isAutorizado: false,
      qtdComentario: 0,
      categorias: [],
      favoritos: [],
    );
  }

  pegarHistoria() {
    String _categoria = currentCategoria.value.idCategoria;

    if (_categoria == CategoriaEnum.ALL.value)
      return _historiaFirestore.historias.orderBy('dataCriacao');
    else if (_categoria == CategoriaEnum.MY.value)
      return _historiaFirestore.historias
          .orderBy('dataCriacao')
          .where('idUsuario', isEqualTo: currentUsuario.value.idUsuario);
    else if (_categoria == CategoriaEnum.BOOKMARK.value)
      return _historiaFirestore.historias.orderBy('dataCriacao').where(
          'favoritos',
          arrayContainsAny: [currentUsuario.value.idUsuario]);
    else
      return _historiaFirestore.historias
          .orderBy('dataCriacao')
          .where('categorias', arrayContainsAny: [_categoria]);
  }

  void adicionar(Map<String, dynamic> history) {
    limparCurrentHistoria();
    currentHistoria.value = HistoriaModel.fromMap(history);
  }

  String definirTextoComentario(Map<String, dynamic> _historia) {
    if (!_historia['isComentario']) return COMENTARIOS_DESABILITADOS;
    if (_historia['qtdComentario'] == 1) return ' comentário';
    if (_historia['qtdComentario'] > 1) return ' $COMENTARIOS_PLURAL';
    return COMENTARIOS_PRIMEIRO;
  }

  bool isComentario(String? _route, Map<String, dynamic> _historia) {
    // if (_route == RouteEnum.historia.value) return false;
    if (_historia['isComentario']) return true;
    return false;
  }
}
