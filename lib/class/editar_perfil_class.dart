import 'package:bluufeed_app/class/atividade_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditarPerfilClass {
  final AtividadeClass _atividadeClass = AtividadeClass();
  final HistoriaClass _historiaClass = HistoriaClass();
  final ToastWidget _toastWidget = ToastWidget();
  final UsuarioClass _usuarioClass = UsuarioClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  bool _alreadyNome = false;

  validarNomeUsuario(String value, String dataAtualizacaoNome) {
    // if (dataAtualizacaoNome.isNotEmpty) {
    //   DateTime agora = DateTime.now();
    //   DateTime dataAtualizacao = DateTime.parse(dataAtualizacaoNome);
    //   DateTime proxima = dataAtualizacao.add(const Duration(days: 7));
    //   String proximaData = DateFormat('dd \'de\' MMM', 'pt_BR').format(proxima);

    //   if (dataAtualizacao.isBefore(agora))
    //     return '$EDITAR_ERRO_DATA $proximaData';
    // }
    // if (value.isEmpty) return EDITAR_ERRO_VAZIO;
    // if (value.length < 6 || value.length > 20) return EDITAR_ERRO_CARACTERES;
    // if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(value))
    //   return EDITAR_ERRO_INVALIDO;
    // if (getNomeUsuario(value)) return EDITAR_ERRO_INDISPONIVEL;
    return null;
  }

  getNomeUsuario(String value) {
    _usuarioFirestore
        .getNomeUsuario(value)
        .then((result) => _alreadyNome = result.size > 0 ? true : false)
        .catchError((error) => print('ERROR => getNomeUsuario: ' + error));
    return _alreadyNome;
  }

  validarBiografia(String value) {
    if (value.length > 501) return EDITAR_ERRO_BIOGRAFIA;
    return null;
  }

  pathPerfil(
    BuildContext context,
    String _idUsuario,
    String _nomeUsuario,
    String _biografia,
  ) async {
    try {
      String _dataAtualizacaoNome = DateTime.now().toString();
      currentUsuario.value.dataAtualizacaoNome = _dataAtualizacaoNome;

      _usuarioFirestore.pathPerfil(
        _nomeUsuario,
        _biografia,
        _dataAtualizacaoNome,
      );

      currentUsuario.value.nomeUsuario = _nomeUsuario;
      await _historiaClass.pathTodosUsuarioHistoria(_nomeUsuario);
      await _usuarioClass.pathTodosUsuarioComentario(_nomeUsuario);
      await _atividadeClass.postAtividade(
        tipoAtividade: AtividadeEnum.UP_PERFIL.value,
        conteudo: _nomeUsuario,
        idConteudo: _idUsuario,
      );
      _toastWidget.toast(context, ToastEnum.SUCESSO, EDITAR_SUCESSO);
    } on FirebaseAuthException {
      _toastWidget.toast(context, ToastEnum.ERRO, ERRO_PERFIL_EDITAR);
    }
  }
}
