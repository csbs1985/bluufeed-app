import 'package:bluufeed_app/class/comentario_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/input/comentario_input_dart.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/comentario_lista_widget.dart';
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
  final TextEditingController _commentController = TextEditingController();
  final Uuid uuid = const Uuid();

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
        'texto': _commentController.text.trim(),
        'situacaoUsuario': currentUsuario.value.situacaoConta
      };

      setState(() {
        widget._historia['qtdComentario']++;
        _comentarioClass.postComentario(context, _comentario, widget._historia);
        Navigator.of(context).pop();
      });
    } on FirebaseAuthException catch (error) {
      debugPrint('$ERRO_POST_COMENTARIO $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ValueListenableBuilder(
          valueListenable: currentQtdHistoria,
          builder: (BuildContext context, int qtdHistoria, _) {
            return TextoText(
                texto:
                    _comentarioClass.definirTextoComentario(widget._historia));
          },
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, UiTamanho.inputTamanho),
        child:
            ComentarioListaWidget(idHistoria: widget._historia['idHistoria']),
      ),
      bottomSheet: ComentarioInput(
          callback: (value) => setState(() => _commentController.text = value)),
      floatingActionButton: _commentController.text.isNotEmpty
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
