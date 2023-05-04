// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:algolia/algolia.dart';

class BuscaModel {
  final String texto;

  BuscaModel({
    required this.texto,
  });
}

enum BuscaEnum {
  HISTORIA('historia'),
  USUARIO('usuario');

  final String value;
  const BuscaEnum(this.value);
}

final List<BuscaModel> listaBusca = [
  BuscaModel(texto: BuscaEnum.HISTORIA.value),
  BuscaModel(texto: BuscaEnum.USUARIO.value),
];

class BuscaClass {
  Algolia? algolia;
  AlgoliaQuery? algoliaQuery;

  List<AlgoliaObjectSnapshot>? _snapshotHistoria;
  List<AlgoliaObjectSnapshot>? _snapshotUsuario;

  getHistoria(String _historia) async {
    AlgoliaQuery _queryHistory =
        algolia!.instance.index('bluufeed_stories').query(_historia);

    AlgoliaQuerySnapshot _snapHistory = await _queryHistory.getObjects();

    if (_snapHistory.hits.isNotEmpty) _snapshotHistoria = _snapHistory.hits;
    if (_historia.isEmpty) _snapshotHistoria = null;
  }

  getUsuario(String _usuario) async {
    AlgoliaQuery _queryUser =
        algolia!.instance.index('bluufeed_users').query(_usuario);

    AlgoliaQuerySnapshot _snapUser = await _queryUser.getObjects();

    if (_snapUser.hits.isNotEmpty) _snapshotUsuario = _snapUser.hits;
    if (_usuario.isEmpty) _snapshotUsuario = null;
  }
}
