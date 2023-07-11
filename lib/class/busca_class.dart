import 'package:algolia/algolia.dart';
import 'package:eight_app/hive/busca_hive.dart';

class BuscaModel {
  final String texto;

  BuscaModel({
    required this.texto,
  });
}

enum BuscaEnum {
  HISTORIA('historia'),
  USUARIO('usuário');

  final String value;
  const BuscaEnum(this.value);
}

final List<BuscaModel> listaBusca = [
  BuscaModel(texto: BuscaEnum.HISTORIA.value),
  BuscaModel(texto: BuscaEnum.USUARIO.value),
];

class BuscaClass {
  final BuscaHive _buscaHive = BuscaHive();

  algoliaToMap(List<AlgoliaObjectSnapshot> algoliaObjects) {
    Map<String, dynamic> resultMap = {};

    for (AlgoliaObjectSnapshot object in algoliaObjects)
      return resultMap[object.objectID] = object.data;
  }

  addHive(String value) {
    _buscaHive.addBusca(value);
  }
}
