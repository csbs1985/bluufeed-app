import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificacaoHive {
  final _buscaBox = Hive.box('notificacao');

  putNotificacao(int _quantidade) async {
    await _buscaBox.put('notificacao', _quantidade);
  }

  getNotificacao() {
    return _buscaBox.get('notificacao');
  }
}
