import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
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
  final TextEditingController _commentController = TextEditingController();

  String description = 'My great package';

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.1,
                color: isDark ? UiCor.placeholderEscuro : UiCor.placeholder,
              ),
            ),
          ),
          child: TextField(
            autofocus: false,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: _commentController,
            onChanged: (value) => widget._callback(value),
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: COMENTARIOS_ESCREVER,
              filled: true,
              fillColor: isDark ? UiCor.mainEscuro : UiCor.main,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        );
      },
    );
  }
}