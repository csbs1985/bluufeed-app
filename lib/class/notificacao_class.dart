import 'package:bluufeed_app/firestore/notificacao_firestore.dart';

class NotificacaoModel {
  late bool isVisualizado;
  late String avatarRemetente;
  late String idRementente;
  late String nomeRemetente;
  late String conteudo;
  late String idConteudo;
  late String idNotificacao;
  late String dataRegistro;
  late String tipoNotificacao;
  late String idDestinatario;

  NotificacaoModel({
    required this.isVisualizado,
    required this.avatarRemetente,
    required this.idRementente,
    required this.nomeRemetente,
    required this.conteudo,
    required this.idConteudo,
    required this.idNotificacao,
    required this.dataRegistro,
    required this.tipoNotificacao,
    required this.idDestinatario,
  });
}

class NotificacaoClass {
  final NotificacaoFirestore _notificacaoFirestore = NotificacaoFirestore();

  String definirConteudo(Map<String, dynamic> _notificacao) {
    return _notificacao['tipoNotificacao'] == NotificacaoEnum.COMMENT.value
        ? '<bold>${_notificacao['nomeRemetente']}</bold> fez um comentou na história <bold>${_notificacao['conteudo']}.</bold>'
        : '<bold>${_notificacao['nomeRemetente']}</bold> compartilhou a história <bold>${_notificacao['conteudo']}</bold> com você.';
  }

  Future<void> pathVizualizarNotificacao(String _idNotificacao) async {
    await _notificacaoFirestore.pathVizualizarNotificacao(_idNotificacao);
  }
}

enum NotificacaoEnum {
  COMMENT('comment'),
  SEND('send');

  final String value;
  const NotificacaoEnum(this.value);
}
