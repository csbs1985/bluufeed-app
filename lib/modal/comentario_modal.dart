import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/input/comentario_input_dart.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  final HistoriaClass _historiaClass = HistoriaClass();
  final TextEditingController _commentController = TextEditingController();

  _receberComentarioController(String value) {
    setState(() {
      _commentController.text = value;
    });
  }

  _postComentario(BuildContext context) {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextoText(
          texto: _historiaClass.definirTextoComentario(widget._historia),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
        child: const SingleChildScrollView(child: TextoText(texto: TESTE)),
      ),
      bottomSheet: ComentarioInput(
          callback: (value) => _receberComentarioController(value)),
      floatingActionButton: _commentController.text.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: UiCor.botao,
              elevation: 0,
              onPressed: () => _postComentario(context),
              child: SvgPicture.asset(UiSvg.criar, color: UiCor.icone),
            )
          : null,
    );
  }
}
