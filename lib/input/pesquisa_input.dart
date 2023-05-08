import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class PesquisaInput extends StatefulWidget {
  const PesquisaInput({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<PesquisaInput> createState() => _PesquisaInputState();
}

class _PesquisaInputState extends State<PesquisaInput> {
  final TextEditingController _buscaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isDark = tema == Brightness.dark;

          return SizedBox(
            height: UiTamanho.inputTamanho,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              autofocus: false,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              controller: _buscaController,
              onChanged: (value) => widget._callback(value),
              style: Theme.of(context).textTheme.displayMedium,
              decoration: InputDecoration(
                hintText: BUSCA_ESCREVER,
                filled: true,
                fillColor: isDark ? UiCor.bordaEscura : UiCor.borda,
                hintStyle: Theme.of(context).textTheme.bodySmall,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: UiEspaco.large,
                  vertical: UiEspaco.small,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
              ),
            ),
          );
        });
  }
}
