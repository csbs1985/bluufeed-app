import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';

class PadraoInput extends StatelessWidget {
  final bool? autoFocus;
  final TextEditingController? controller;
  final Function? callback;
  final bool? expands;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? Function(String?)? validator;

  const PadraoInput({
    Key? key,
    this.autoFocus = false,
    this.controller,
    this.callback,
    this.expands = false,
    this.focusNode,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return SizedBox(
          child: TextFormField(
            autofocus: autoFocus!,
            controller: controller,
            expands: expands!,
            focusNode: focusNode,
            keyboardType: keyboardType,
            onChanged: (value) => callback!(value),
            onSaved: onSaved,
            maxLength: maxLength,
            minLines: minLines,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.displayMedium,
            textAlignVertical: TextAlignVertical.center,
            validator: validator,
            decoration: InputDecoration(
              counterStyle: Theme.of(context).textTheme.headlineSmall,
              hintText: hintText,
              filled: true,
              fillColor: isDark ? UiCor.bordaEscura : UiCor.borda,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              errorStyle: UiTexto.erro,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: UiEspaco.medium,
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
      },
    );
  }
}
