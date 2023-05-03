import 'package:bluufeed_app/class/token_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bluufeed_app/class/bloqueado_class.dart';
import 'package:bluufeed_app/class/seguindo_class.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/hive/usuario_hive.dart';

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
  late bool notificacao;
  late int qtdFavoritos;
  late int qtdComentarios;
  late int qtdDenuncias;
  late int qtdHistorias;
  late List<BloqueadoModel> bloqueados;
  late List<SeguindoModel> seguindo;

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
    required this.notificacao,
    required this.qtdFavoritos,
    required this.qtdComentarios,
    required this.qtdDenuncias,
    required this.qtdHistorias,
    required this.bloqueados,
    required this.seguindo,
  });
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
  notificacao: false,
  qtdFavoritos: 0,
  qtdComentarios: 0,
  qtdDenuncias: 0,
  qtdHistorias: 0,
  bloqueados: [],
  seguindo: [],
));

class UsuarioClass {
  final TokenClass _tokenClass = TokenClass();
  final UsuarioHive _usuarioHive = UsuarioHive();
  final UsuarioFirestore _usuarioFirebase = UsuarioFirestore();

  definirUsuario(Map<String, dynamic> usuario) async {
    QuerySnapshot doc =
        await _usuarioFirebase.getUsuarioEmail(usuario['email']!);

    if (doc.docs.isNotEmpty) {
      currentUsuario.value = UsuarioModel(
        avatarUsuario: doc.docs.first['avatarUsuario'],
        biografia: doc.docs.first['biografia'],
        idUsuario: doc.docs.first['idUsuario'],
        dataRegistro: doc.docs.first['dataRegistro'],
        nomeUsuario: doc.docs.first['nome'],
        email: doc.docs.first['email'],
        situacaoConta: SituacaoUsuarioEnum.ATIVO.value,
        token: doc.docs.first['token'],
        dataAtualizacaoNome: doc.docs.first['dataAtualizacaoNome'],
        notificacao: doc.docs.first['notificacao'],
        qtdFavoritos: doc.docs.first['qtdFavoritos'],
        qtdComentarios: doc.docs.first['qtdComentarios'],
        qtdDenuncias: doc.docs.first['qtdDenuncias'],
        qtdHistorias: doc.docs.first['qtdHistorias'],
        bloqueados: doc.docs.first['bloqueados'],
        seguindo: doc.docs.first['seguindo'],
      );
    } else {
      currentUsuario.value = UsuarioModel(
        avatarUsuario: usuario['photoUrl'],
        biografia: '',
        idUsuario: usuario['uid'],
        dataRegistro: DateTime.now().toString(),
        nomeUsuario: usuario['displayName'],
        email: usuario['email']!,
        situacaoConta: SituacaoUsuarioEnum.CRIANDO.value,
        token: await _tokenClass.pegarToken(),
        dataAtualizacaoNome: '',
        notificacao: true,
        qtdFavoritos: 0,
        qtdComentarios: 0,
        qtdDenuncias: 0,
        qtdHistorias: 0,
        bloqueados: [],
        seguindo: [],
      );
    }

    definirUsuarioHive();
  }

  definirUsuarioHive() {
    Map<String, dynamic> usuarioMap = {
      'avatarUsuario': currentUsuario.value.avatarUsuario,
      'biografia': currentUsuario.value.biografia,
      'idUsuario': currentUsuario.value.idUsuario,
      'dataRegistro': currentUsuario.value.dataRegistro,
      'nome': currentUsuario.value.nomeUsuario,
      'email': currentUsuario.value.email,
      'situacaoConta': currentUsuario.value.situacaoConta,
      'token': currentUsuario.value.token,
      'dataAtualizacaoNome': currentUsuario.value.dataAtualizacaoNome,
      'notificacao': currentUsuario.value.notificacao,
      'qtdFavoritos': currentUsuario.value.qtdFavoritos,
      'qtdComentarios': currentUsuario.value.qtdComentarios,
      'qtdDenuncias': currentUsuario.value.qtdDenuncias,
      'qtdHistorias': currentUsuario.value.qtdHistorias,
      'bloqueados': currentUsuario.value.bloqueados,
      'seguindo': currentUsuario.value.seguindo,
    };

    _usuarioHive.addUsuario(usuarioMap);
    _usuarioFirebase.postUsuario(usuarioMap);
  }

  deleteUsuario() {
    deletarUsuarioCurrent();
    _usuarioHive.deleteUsuario();
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
      notificacao: false,
      qtdFavoritos: 0,
      qtdComentarios: 0,
      qtdDenuncias: 0,
      qtdHistorias: 0,
      bloqueados: [],
      seguindo: [],
    );
  }
}

enum SituacaoUsuarioEnum {
  ATIVO('/ativo'),
  INATIVO('/inativo'),
  CRIANDO('/criando'),
  DELETADO('/deletado');

  final String value;
  const SituacaoUsuarioEnum(this.value);
}
