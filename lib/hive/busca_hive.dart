import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BuscaHive {
  final _buscaBox = Hive.box('busca');

  addBusca(String busca) async {
    await _buscaBox.add(busca);
  }

  deleteBusca(String value) async {
    final lista = await _buscaBox.get('nomeDaLista') as List<String>;
    lista.remove(value);
  }

  listaBusca() {
    return _buscaBox.values.toList();
  }
}
