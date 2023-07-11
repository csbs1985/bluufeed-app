import 'package:eight_app/class/comentario_class.dart';
import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/input/padrao_input.dart';
import 'package:eight_app/text/animado_text.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_svg.dart';
import 'package:eight_app/theme/ui_tamanho.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:eight_app/widget/comentario_lista_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';

class ComentarioModal extends StatefulWidget {
  const ComentarioModal({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<ComentarioModal> createState() => _ComentarioModalState();
}

class _ComentarioModalState extends State<ComentarioModal> {
  final ComentarioClass _comentarioClass = ComentarioClass();
  final TextEditingController _comentarioController = TextEditingController();
  final Uuid uuid = const Uuid();

  String _texto = "";

  void _definirTexto(String value) {
    setState(() => _texto = value);
  }

  _postComentario(BuildContext context) {
    try {
      Map<String, dynamic> _comentario = {
        'avatarUsuario': currentUsuario.value.avatarUsuario,
        'idUsuario': currentUsuario.value.idUsuario,
        'nomeUsuario': currentUsuario.value.nomeUsuario,
        'dataRegistro': DateTime.now().toString(),
        'idHistoria': widget._historia['idHistoria'],
        'idComentario': uuid.v4(),
        'isEditado': false,
        'isDeletado': false,
        'isAnonimo': false,
        'texto': _texto.trim(),
        'situacaoUsuario': currentUsuario.value.situacaoConta
      };

      setState(() {
        widget._historia['qtdComentario']++;
        _comentarioClass.postComentario(context, _comentario, widget._historia);
        _comentarioController.clear();
        _texto = "";
      });
    } on FirebaseAuthException catch (error) {
      debugPrint('$ERRO_POST_COMENTARIO $error');
    }
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AnimadoText(item: widget._historia),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, UiTamanho.inputTamanho),
        child:
            ComentarioListaWidget(idHistoria: widget._historia['idHistoria']),
      ),
      bottomSheet: ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isDark = tema == Brightness.dark;

          return Container(
            color: isDark ? UiCor.mainEscuro : UiCor.main,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: PadraoInput(
              callback: (value) => _definirTexto(value),
              controller: _comentarioController,
              hintText: COMENTARIOS_ESCREVER,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          );
        },
      ),
      floatingActionButton: _comentarioController.text.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: UiCor.botao,
              elevation: 0,
              onPressed: () => _postComentario(context),
              child: SvgPicture.asset(
                UiSvg.confirmar,
                color: UiCor.icone,
              ),
            )
          : null,
    );
  }
}
