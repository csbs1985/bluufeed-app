import 'package:bluufeed_app/class/bloqueado_class.dart';
import 'package:bluufeed_app/class/seguindo_class.dart';

class UsuarioModel {
  late String biografia;
  late String idUsuario;
  late String dataRegistro;
  late String nome;
  late String situacaoConta;
  late String token;
  late String dataAtualizacaoNome;
  late bool notificacao;
  late int qtdFavoritos;
  late int qtdComentarios;
  late int qtdDenuncias;
  late int qtdHistorias;
  late List<BloqueadoModel> bloqueados;
  late List<SeguindoModel> seguindo;

  UsuarioModel({
    required this.biografia,
    required this.idUsuario,
    required this.dataRegistro,
    required this.nome,
    required this.situacaoConta,
    required this.token,
    required this.dataAtualizacaoNome,
    required this.notificacao,
    required this.qtdFavoritos,
    required this.qtdComentarios,
    required this.qtdDenuncias,
    required this.qtdHistorias,
    required this.bloqueados,
    required this.seguindo,
  });
}
