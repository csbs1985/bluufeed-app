import 'package:algolia/algolia.dart';
import 'package:bluufeed_app/class/atividade_class.dart';
import 'package:bluufeed_app/class/token_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/hive/usuario_hive.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsuarioModel {
  late String avatarUsuario;
  late String biografia;
  late String email;
  late String idUsuario;
  late String dataRegistro;
  late String nomeUsuario;
  late String token;
  late String dataAtualizacaoNome;
  late String situacaoConta;
  late bool isNotificacao;
  late int qtdFavoritos;
  late int qtdComentarios;
  late int qtdDenuncias;
  late int qtdHistorias;
  late List<String> bloqueados;
  late List<String> favoritos;
  late List<String> seguindo;

  UsuarioModel({
    required this.avatarUsuario,
    required this.biografia,
    required this.email,
    required this.idUsuario,
    required this.dataRegistro,
    required this.nomeUsuario,
    required this.situacaoConta,
    required this.token,
    required this.dataAtualizacaoNome,
    required this.isNotificacao,
    required this.qtdFavoritos,
    required this.qtdComentarios,
    required this.qtdDenuncias,
    required this.qtdHistorias,
    required this.bloqueados,
    required this.favoritos,
    required this.seguindo,
  });

  static Map<String, dynamic> toMap(usuario) => {
        'avatarUsuario': usuario['avatarUsuario'],
        'biografia': usuario['biografia'],
        'email': usuario['email'],
        'idUsuario': usuario['idUsuario'],
        'dataRegistro': usuario['dataRegistro'],
        'nomeUsuario': usuario['nomeUsuario'],
        'token': usuario['token'],
        'dataAtualizacaoNome': usuario['dataAtualizacaoNome'],
        'situacaoConta': usuario['situacaoConta'],
        'isNotificacao': usuario['isNotificacao'],
        'qtdFavoritos': usuario['qtdFavoritos'],
        'qtdComentarios': usuario['qtdComentarios'],
        'qtdDenuncias': usuario['qtdDenuncias'],
        'qtdHistorias': usuario['qtdHistorias'],
        'bloqueados': usuario['bloqueados'],
        'favoritos': usuario['favoritos'].cast<String>(),
        'seguindo': usuario['seguindo'],
      };
}

ValueNotifier<UsuarioModel> currentUsuario =
    ValueNotifier<UsuarioModel>(UsuarioModel(
  avatarUsuario: '',
  biografia: '',
  email: '',
  idUsuario: '',
  dataRegistro: '',
  nomeUsuario: '',
  situacaoConta: '',
  token: '',
  dataAtualizacaoNome: '',
  isNotificacao: false,
  qtdFavoritos: 0,
  qtdComentarios: 0,
  qtdDenuncias: 0,
  qtdHistorias: 0,
  bloqueados: [],
  favoritos: [],
  seguindo: [],
));

class UsuarioClass {
  final AtividadeClass _atividadeClass = AtividadeClass();
  final ToastWidget _toastWidget = ToastWidget();
  final TokenClass _tokenClass = TokenClass();
  final UsuarioHive _usuarioHive = UsuarioHive();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  Map<String, dynamic>? _usuarioMap;

  bool isDonoUsuario(String _idUsuario) {
    return currentUsuario.value.idUsuario == _idUsuario ? true : false;
  }

  verificarHive() {
    final _usuario = _usuarioHive.readUsuario();

    _usuarioMap = {
      'avatarUsuario': _usuario['avatarUsuario'],
      'biografia': _usuario['biografia'],
      'idUsuario': _usuario['idUsuario'],
      'dataRegistro': _usuario['dataRegistro'],
      'nomeUsuario': _usuario['nomeUsuario'],
      'email': _usuario['email'],
      'situacaoConta': SituacaoUsuarioEnum.ATIVO.value,
      'token': _usuario['token'],
      'dataAtualizacaoNome': _usuario['dataAtualizacaoNome'],
      'isNotificacao': _usuario['isNotificacao'],
      'qtdFavoritos': _usuario['qtdFavoritos'],
      'qtdComentarios': _usuario['qtdComentarios'],
      'qtdDenuncias': _usuario['qtdDenuncias'],
      'qtdHistorias': _usuario['qtdHistorias'],
      'bloqueados': _usuario['bloqueados'].cast<String>(),
      'favoritos': _usuario['favoritos'].cast<String>(),
      'seguindo': _usuario['seguindo'].cast<String>(),
    };

    hiveToValueNotifier(_usuarioMap!);
  }

  List<Map<String, dynamic>> algoliaToMap(
      List<AlgoliaObjectSnapshot> _snapshot) {
    List<Map<String, dynamic>> _usuario =
        _snapshot.map((snapshot) => snapshot.data).toList();
    return _usuario;
  }

  Map<String, dynamic> formatarMapUsuarioItem(Map<String, dynamic> _historia) {
    Map<String, dynamic> _usuario = {
      'avatarUsuario': _historia['avatarUsuario'],
      'idUsuario': _historia['idUsuario'],
      'nomeUsuario': _historia['nomeUsuario'],
    };

    return _usuario;
  }

  definirUsuario(Map<String, dynamic> usuario) async {
    QuerySnapshot doc =
        await _usuarioFirestore.getUsuarioEmail(usuario['email']!);

    if (doc.docs.isNotEmpty) {
      _usuarioMap = {
        'avatarUsuario': doc.docs.first['avatarUsuario'],
        'biografia': doc.docs.first['biografia'],
        'idUsuario': doc.docs.first['idUsuario'],
        'dataRegistro': doc.docs.first['dataRegistro'],
        'nomeUsuario': doc.docs.first['nomeUsuario'],
        'email': doc.docs.first['email'],
        'situacaoConta': SituacaoUsuarioEnum.ATIVO.value,
        'token': doc.docs.first['token'],
        'dataAtualizacaoNome': doc.docs.first['dataAtualizacaoNome'],
        'isNotificacao': doc.docs.first['isNotificacao'],
        'qtdFavoritos': doc.docs.first['qtdFavoritos'],
        'qtdComentarios': doc.docs.first['qtdComentarios'],
        'qtdDenuncias': doc.docs.first['qtdDenuncias'],
        'qtdHistorias': doc.docs.first['qtdHistorias'],
        'bloqueados': doc.docs.first['bloqueados'].cast<String>(),
        'favoritos': doc.docs.first['favoritos'].cast<String>(),
        'seguindo': doc.docs.first['seguindo'].cast<String>(),
      };
    } else {
      _usuarioMap = {
        'avatarUsuario': usuario['photoUrl'],
        'biografia': '',
        'idUsuario': usuario['uid'],
        'dataRegistro': DateTime.now().toString(),
        'nomeUsuario': usuario['displayName'],
        'email': usuario['email']!,
        'situacaoConta': SituacaoUsuarioEnum.CRIANDO.value,
        'token': await _tokenClass.pegarToken(),
        'dataAtualizacaoNome': '',
        'isNotificacao': true,
        'qtdFavoritos': 0,
        'qtdComentarios': 0,
        'qtdDenuncias': 0,
        'qtdHistorias': 0,
        'bloqueados': [],
        'favoritos': [],
        'seguindo': [],
      };
    }

    definirUsuarioHive(_usuarioMap!);
  }

  definirUsuarioHive(Map<String, dynamic> _usuarioMap) {
    hiveToValueNotifier(_usuarioMap);
    _usuarioHive.addUsuario(_usuarioMap);
    _usuarioFirestore.postUsuario(_usuarioMap);
  }

  hiveToValueNotifier(Map<String, dynamic> _usuarioMap) {
    currentUsuario.value = UsuarioModel(
      avatarUsuario: _usuarioMap['avatarUsuario'],
      biografia: _usuarioMap['biografia'],
      idUsuario: _usuarioMap['idUsuario'],
      dataRegistro: _usuarioMap['dataRegistro'],
      nomeUsuario: _usuarioMap['nomeUsuario'],
      email: _usuarioMap['email'],
      situacaoConta: _usuarioMap['situacaoConta'],
      token: _usuarioMap['token'],
      dataAtualizacaoNome: _usuarioMap['dataAtualizacaoNome'],
      isNotificacao: _usuarioMap['isNotificacao'],
      qtdFavoritos: _usuarioMap['qtdFavoritos'],
      qtdComentarios: _usuarioMap['qtdComentarios'],
      qtdDenuncias: _usuarioMap['qtdDenuncias'],
      qtdHistorias: _usuarioMap['qtdHistorias'],
      bloqueados: _usuarioMap['bloqueados'].cast<String>(),
      favoritos: _usuarioMap['favoritos'].cast<String>(),
      seguindo: _usuarioMap['seguindo'].cast<String>(),
    );
  }

  deleteUsuario() {
    deletarUsuarioCurrent();
    _usuarioHive.deleteUsuario();
  }

  deletarConta() {
    _usuarioFirestore.pathSituacaoConta(SituacaoUsuarioEnum.DELETADO.value);
  }

  mapDynamicToMapString(Map<dynamic, dynamic> usuario) {
    return usuario.map((chave, valor) => MapEntry(chave.toString(), valor));
  }

  userToMap(User usuario) {
    Map<String, dynamic> userMap = {
      'uid': usuario.uid,
      'displayName': usuario.displayName,
      'email': usuario.email,
      'photoUrl': usuario.photoURL,
    };

    return userMap;
  }

  deletarUsuarioCurrent() {
    currentUsuario.value = UsuarioModel(
      avatarUsuario: '',
      biografia: '',
      idUsuario: '',
      email: '',
      dataRegistro: '',
      nomeUsuario: '',
      situacaoConta: '',
      token: '',
      dataAtualizacaoNome: '',
      isNotificacao: true,
      qtdFavoritos: 0,
      qtdComentarios: 0,
      qtdDenuncias: 0,
      qtdHistorias: 0,
      bloqueados: [],
      favoritos: [],
      seguindo: [],
    );
  }

  toggleSeguindoUsuario(String _idUsuario) {
    List<String> listaSeguindo = currentUsuario.value.seguindo.cast<String>();

    bool encontrou = listaSeguindo.any((map) => map == _idUsuario);
    encontrou
        ? listaSeguindo.removeWhere((map) => map == _idUsuario)
        : listaSeguindo.add(_idUsuario);

    _usuarioFirestore.pathSeguindo(listaSeguindo);
    currentUsuario.value.seguindo = listaSeguindo.cast<String>();
  }

  String isSeguindoUsuario(String _idUsuario) {
    List<String> listaSeguindo = currentUsuario.value.seguindo.cast<String>();

    bool encontrou = listaSeguindo.any((map) => map == _idUsuario);
    return encontrou ? SEGUINDO : SEGUIR;
  }

  pathQtdHistoriasUsuario(
    BuildContext context,
    bool _isEditado,
    String _tituloController,
    String _idHistoria,
  ) async {
    if (!_isEditado)
      await _usuarioFirestore.pathQtdHistoriasUsuario(currentUsuario.value);

    _atividadeClass.postAtividade(
      tipoAtividade: _isEditado
          ? AtividadeEnum.UP_HISTORY.value
          : AtividadeEnum.NEW_HISTORY.value,
      conteudo: _tituloController,
      idConteudo: _idHistoria,
    );

    _toastWidget.toast(
      context,
      ToastEnum.SUCESSO,
      _isEditado ? HISTORIA_ALTERADA : HISTORIA_PUBLICADA,
    );
  }

  Future<void> pathTodosUsuarioComentario(String _nomeUsuario) async {
    final query = _usuarioFirestore.pathTodosUsuarioComentario();

    query.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'nomeUsuario': _nomeUsuario});
      });
    });
  }

  pathNotificacao(bool _isNotificacao) {
    currentUsuario.value.isNotificacao = _isNotificacao;
    _usuarioFirestore.pathNotificacao();
  }

  Map<String, dynamic> getUsuarioId(String _idUsuario) {
    Map<String, dynamic> _usuario = _usuarioFirestore.getUsuarioId(_idUsuario);
    return _usuario;
  }

  List<Map<String, dynamic>> getListaUsuarios(
    QueryDocumentSnapshot<dynamic> snapshot,
  ) {
    List<dynamic> seguindoList = snapshot['seguindo'];
    List<Map<String, dynamic>> resultados = [];

    for (dynamic idUsuario in seguindoList) {
      // Future<dynamic> futureUsuario = getUsuarioId(idUsuario);
      // Map<String, dynamic> _usuario = futureUsuario as Map<String, dynamic>;
      // resultados.add(_usuario);
    }

    return resultados;
  }
}

enum SituacaoUsuarioEnum {
  ATIVO('ativo'),
  INATIVO('inativo'),
  CRIANDO('criando'),
  DELETADO('deletado');

  final String value;
  const SituacaoUsuarioEnum(this.value);
}
