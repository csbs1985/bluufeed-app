import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/input/padrao_input.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class ComentarioInput extends StatefulWidget {
  const ComentarioInput({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<ComentarioInput> createState() => _ComentarioInputState();
}

class _ComentarioInputState extends State<ComentarioInput> {
  final TextEditingController _comentarioController = TextEditingController();

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          color: isDark ? UiCor.mainEscuro : UiCor.main,
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: PadraoInput(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: _comentarioController,
            callback: (value) => setState(() => widget._callback(value)),
            hintText: COMENTARIOS_ESCREVER,
          ),
        );
      },
    );
  }
}
