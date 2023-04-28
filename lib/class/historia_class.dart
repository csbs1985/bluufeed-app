import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/favorito_class.dart';
import 'package:flutter/material.dart';

ValueNotifier<HistoriaModel> currentHistory =
    ValueNotifier<HistoriaModel>(HistoriaModel(
  idHistoria: '',
  titulo: '',
  texto: '',
  dataCriacao: '',
  idUsuario: '',
  nameUsuario: '',
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
  late String nameUsuario;
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
    required this.nameUsuario,
    required this.isComentario,
    required this.isAssinado,
    required this.isEditado,
    required this.isAutorizado,
    required this.qtdComentario,
    required this.categorias,
    required this.favoritos,
  });
}

class HistoriaClass {
  limparCurrentHistoria() {
    currentHistory.value = HistoriaModel(
      idHistoria: '',
      titulo: '',
      texto: '',
      dataCriacao: '',
      idUsuario: '',
      nameUsuario: '',
      isComentario: false,
      isAssinado: false,
      isEditado: false,
      isAutorizado: false,
      qtdComentario: 0,
      categorias: [],
      favoritos: [],
    );
  }
}
