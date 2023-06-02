import 'package:bluufeed_app/button/comentario_button.dart';
import 'package:bluufeed_app/button/enviar_button.dart';
import 'package:bluufeed_app/button/favorito_button.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

class HistoriaInteracaoWidget extends StatefulWidget {
  const HistoriaInteracaoWidget({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<HistoriaInteracaoWidget> createState() =>
      _HistoriaInteracaoWidgetState();
}

class _HistoriaInteracaoWidgetState extends State<HistoriaInteracaoWidget> {
  @override
  void initState() {
    currentQtdHistoria.value = widget._historia['qtdComentario'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ComentarioButton(historia: widget._historia),
          FavoritoButton(idHistoria: widget._historia['idHistoria']),
          EnviarButton(historia: widget._historia),
        ],
      ),
    );
  }
}
