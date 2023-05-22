import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bluufeed_app/class/comentario_class.dart';
import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimadoText extends StatelessWidget {
  const AnimadoText({
    super.key,
    bool? isBotao = false,
    required Map<String, dynamic> item,
  })  : _item = item,
        _isBotao = isBotao;

  final Map<String, dynamic> _item;
  final bool? _isBotao;

  @override
  Widget build(BuildContext context) {
    final ComentarioClass _comentarioClass = ComentarioClass();

    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;
        return Padding(
          padding: EdgeInsets.all(_isBotao == true ? 16 : 0),
          child: Row(
            children: [
              if (_isBotao == true)
                SvgPicture.asset(
                  UiSvg.comentario,
                  color: UiCor.icone,
                ),
              if (_isBotao == true) const SizedBox(width: 4),
              if (_item['isComentario'] && _item['qtdComentario'] > 0)
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 300),
                  value: _item['qtdComentario'],
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                ),
              if (_item['isComentario'] && _item['qtdComentario'] > 0)
                const SizedBox(width: 4),
              LegendaText(
                  legenda: _comentarioClass.definirTextoComentario(_item)),
            ],
          ),
        );
      },
    );
  }
}
