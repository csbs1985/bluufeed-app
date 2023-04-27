class AtividadeModel {
  late String conteudo;
  late String dataAtividade;
  late String idAtividade;
  late String idConteudo;
  late String idUsuario;
  late String tipoAtividade;

  AtividadeModel({
    required this.conteudo,
    required this.dataAtividade,
    required this.idAtividade,
    required this.idConteudo,
    required this.idUsuario,
    required this.tipoAtividade,
  });
}

enum AtividadeEnum {
  BLOCK_USER('block_user'),
  DELETE_COMMENT('delete_comment'),
  DELETE_HISTORY('delete_history'),
  DENOUNCE('denounce'),
  FOLLOWING('following'),
  LOGIN('login'),
  LOGOUT('logout'),
  NEW_ACCOUNT('new_account'),
  NEW_COMMENT('new_comment'),
  NEW_HISTORY('new_history'),
  NEW_NICKNAME('new_nickname'),
  TEMPORARILY_DISABLED('temporarily_disabled'),
  UP_COMMENT('up_comment'),
  UP_HISTORY('up_history'),
  UP_NICKNAME('up_nickname'),
  UP_NOTIFICATION('up_notification'),
  UP_BIOGRAPHY('up_biography'),
  UNBLOCK_USER('unblock_user');

  final String value;
  const AtividadeEnum(this.value);
}
