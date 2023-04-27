class ComentarioModel {
  late String dataCriacao;
  late String idComentario;
  late String idHistoria;
  late String idUsuario;
  late String nomeUsuario;
  late String situacaoUsuario;
  late String texto;
  late bool isAssinada;
  late bool isDeletada;
  late bool isEdita;

  ComentarioModel({
    required this.dataCriacao,
    required this.idComentario,
    required this.idHistoria,
    required this.idUsuario,
    required this.nomeUsuario,
    required this.situacaoUsuario,
    required this.texto,
    required this.isAssinada,
    required this.isDeletada,
    required this.isEdita,
  });
}
