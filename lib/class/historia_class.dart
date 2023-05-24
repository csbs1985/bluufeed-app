import 'package:flutter/material.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/firestore/historia_firestore.dart';

ValueNotifier<int> currentQtdHistoria = ValueNotifier<int>(0);

ValueNotifier<HistoriaModel> currentHistoria =
    ValueNotifier<HistoriaModel>(HistoriaModel(
  idHistoria: '',
  titulo: '',
  texto: '',
  dataRegistro: '',
  idUsuario: '',
  isComentario: false,
  isAnonimo: false,
  isEditado: false,
  isAutorizado: false,
  qtdComentario: 0,
  categorias: [],
));

class HistoriaModel {
  late String idHistoria;
  late String titulo;
  late String texto;
  late String dataRegistro;
  late String idUsuario;
  late bool isComentario;
  late bool isAnonimo;
  late bool isEditado;
  late bool isAutorizado;
  late int qtdComentario;
  late List<CategoriaModel> categorias;

  HistoriaModel({
    required this.idHistoria,
    required this.titulo,
    required this.texto,
    required this.dataRegistro,
    required this.idUsuario,
    required this.isComentario,
    required this.isAnonimo,
    required this.isEditado,
    required this.isAutorizado,
    required this.qtdComentario,
    required this.categorias,
  });

  static Map<String, dynamic> toMap(historia) => {
        'idHistoria': historia['idHistoria'],
        'titulo': historia['titulo'],
        'texto': historia['texto'],
        'dataRegistro': historia['dataRegistro'],
        'isComentario': historia['isComentario'],
        'isAnonimo': historia['isAnonimo'],
        'isEditado': historia['isEditado'],
        'isAutorizado': historia['isAutorizado'],
        'idUsuario': historia['idUsuario'],
        'qtdComentario': historia['qtdComentario'],
        'categorias': historia['categorias'].cast<String>(),
      };

  static HistoriaModel fromMap(Map<String, dynamic> map) {
    return HistoriaModel(
      idHistoria: map['idHistoria'],
      titulo: map['titulo'],
      texto: map['texto'],
      dataRegistro: map['dataRegistro'],
      idUsuario: map['idUsuario'],
      isComentario: map['isComentario'],
      isAnonimo: map['isAnonimo'],
      isEditado: map['isEditado'],
      isAutorizado: map['isAutorizado'],
      qtdComentario: map['qtdComentario'],
      categorias: map['categorias'].cast<CategoriaModel>(),
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
      dataRegistro: '',
      idUsuario: '',
      isComentario: false,
      isAnonimo: false,
      isEditado: false,
      isAutorizado: false,
      qtdComentario: 0,
      categorias: [],
    );
  }

  pegarHistoria() {
    String _categoria = currentCategoria.value.idCategoria;

    if (_categoria == CategoriaEnum.ALL.value)
      return _historiaFirestore.historias.orderBy('dataRegistro');
    else if (_categoria == CategoriaEnum.MY.value)
      return _historiaFirestore.historias
          .orderBy('dataRegistro')
          .where('idUsuario', isEqualTo: currentUsuario.value.idUsuario);
    else if (_categoria == CategoriaEnum.BOOKMARK.value)
      return _historiaFirestore.historias.orderBy('dataRegistro').where(
          'favoritos',
          arrayContainsAny: [currentUsuario.value.idUsuario]);
    else
      return _historiaFirestore.historias
          .orderBy('dataRegistro')
          .where('categorias', arrayContainsAny: [_categoria]);
  }

  void adicionar(Map<String, dynamic> history) {
    limparCurrentHistoria();
    currentHistoria.value = HistoriaModel.fromMap(history);
  }

  bool isComentario(String? _route, Map<String, dynamic> _historia) {
    // if (_route == RouteEnum.historia.value) return false;
    if (_historia['isComentario']) return true;
    return false;
  }

  Future<void> pathTodosUsuarioHistoria(String _nomeUsuario) async {
    final query = _historiaFirestore.pathTodosUsuarioHistoria();

    query.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'nomeUsuario': _nomeUsuario});
      });
    });
  }

  Future<void> deletarTodasHistoriaUsuario() async {
    await _historiaFirestore
        .getAllHistoriaIdUsuario(currentUsuario.value.idUsuario)
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await _historiaFirestore.deletarHistoriaId(item['idHistory']),
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }
}
