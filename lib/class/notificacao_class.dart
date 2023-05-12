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
