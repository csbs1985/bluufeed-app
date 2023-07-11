import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/firestore/atividade_firestore.dart';
import 'package:eight_app/firestore/usuario_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AtividadeModel {
  late String conteudo;
  late String dataRegistro;
  late String idAtividade;
  late String idConteudo;
  late String idUsuario;
  late String tipoAtividade;
  late String avatarUsuario;

  AtividadeModel({
    required this.conteudo,
    required this.dataRegistro,
    required this.idAtividade,
    required this.idConteudo,
    required this.idUsuario,
    required this.tipoAtividade,
    required this.avatarUsuario,
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
  UP_PERFIL('UP_PERFIL'),
  UP_NOTIFICATION('up_notification'),
  UP_BIOGRAPHY('up_biography'),
  UNBLOCK_USER('unblock_user');

  final String value;
  const AtividadeEnum(this.value);
}

class AtividadeClass {
  final AtividadeFirestore _atividadeFirestore = AtividadeFirestore();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();
  final Uuid uuid = const Uuid();

  postAtividade({
    required String tipoAtividade,
    required String conteudo,
    required String idConteudo,
  }) async {
    Map<String, dynamic> _atividade = {
      'conteudo': conteudo.trim(),
      'dataRegistro': DateTime.now().toString(),
      'idConteudo': idConteudo,
      'idAtividade': uuid.v4(),
      'tipoAtividade': tipoAtividade,
      'idUsuario': currentUsuario.value.idUsuario,
    };

    await _atividadeFirestore.postAtividade(_atividade);
  }

  Future<String> formatarAtividade(Map<String, dynamic> _atividade) async {
    QuerySnapshot _usuario =
        await _usuarioFirestore.getUsuarioId(_atividade['idUsuario']);

    String _tipo = _atividade['tipoAtividade'];

    if (_tipo == AtividadeEnum.BLOCK_USER.value)
      return '<bold>${_usuario.docs.first['nomeUsuario']}</bold>';
    return 'Avividade';
  }
}
