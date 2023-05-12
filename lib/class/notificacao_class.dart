import 'package:bluufeed_app/firestore/notificacao_firestore.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';

class NotificacaoModel {
  late bool isVisualizado;
  late String avatarRemetente;
  late String idRementente;
  late String nomeRemetente;
  late String conteudo;
  late String idConteudo;
  late String idNotificacao;
  late String dataNotificacao;
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
    required this.dataNotificacao,
    required this.tipoNotificacao,
    required this.idDestinatario,
  });
}

ValueNotifier<bool> currentNotificacao = ValueNotifier<bool>(false);

class NotificacaoClass {
  final NotificacaoFirestore _notificacaoFirestore = NotificacaoFirestore();

  String definirConteudo(Map<String, dynamic> _notificacao) {
    return _notificacao['tipoNotificacao'] == NotificacaoEnum.COMMENT.value
        ? '<bold>${_notificacao['nomeRemetente']}</bold> fez um comentou na história <bold>${_notificacao['conteudo']}.</bold>'
        : '<bold>${_notificacao['nomeRemetente']}</bold> compartilhou a história <bold>${_notificacao['conteudo']}</bold> com você.';
  }

  Color definirCor(bool tema, bool _isVisualizado) {
    if (_isVisualizado) return tema ? UiCor.mainEscuro : UiCor.main;
    return tema ? UiCor.elementoEscura : UiCor.elemento;
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
