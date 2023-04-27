import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/favorito_class.dart';

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
