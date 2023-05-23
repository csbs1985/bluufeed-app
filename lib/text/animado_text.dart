import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bluufeed_app/class/comentario_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:flutter/material.dart';

class AnimadoText extends StatelessWidget {
  const AnimadoText({
    super.key,
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  @override
  Widget build(BuildContext context) {
    final ComentarioClass _comentarioClass = ComentarioClass();

    return ValueListenableBuilder(
      valueListenable: currentHistoria,
      builder: (BuildContext context, HistoriaModel _historia, _) {
        return Row(
          children: [
            if (_historia.isComentario && _historia.qtdComentario > 0)
              Row(
                children: [
                  AnimatedFlipCounter(
                    duration: const Duration(milliseconds: 300),
                    value: _historia.qtdComentario,
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            LegendaText(
              legenda: _comentarioClass.definirTextoComentario(_item),
            ),
          ],
        );
      },
    );
  }
}
