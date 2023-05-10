import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class PadraoInput extends StatefulWidget {
  const PadraoInput({
    super.key,
    bool? autoFocus = false,
    Function? callback,
    TextEditingController? controller,
    bool? expands = false,
    FocusNode? focusNode,
    String? hintText,
    TextInputType? keyboardType = TextInputType.text,
    int? maxLength,
    int? maxLines = 1,
    int? minLines = 1,
  })  : _autoFocus = autoFocus,
        _callback = callback,
        _controller = controller,
        _expands = expands,
        _focusNode = focusNode,
        _hintText = hintText,
        _keyboardType = keyboardType,
        _maxLength = maxLength,
        _maxLines = maxLines,
        _minLines = minLines;

  final bool? _autoFocus;
  final TextEditingController? _controller;
  final Function? _callback;
  final bool? _expands;
  final FocusNode? _focusNode;
  final String? _hintText;
  final TextInputType? _keyboardType;
  final int? _maxLength;
  final int? _minLines;
  final int? _maxLines;

  @override
  State<PadraoInput> createState() => _PadraoInputState();
}

class _PadraoInputState extends State<PadraoInput> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return SizedBox(
          child: TextField(
            autofocus: widget._autoFocus!,
            controller: widget._controller,
            expands: widget._expands!,
            focusNode: widget._focusNode,
            keyboardType: widget._keyboardType,
            onChanged: (value) => widget._callback!(value),
            maxLength: widget._maxLength,
            minLines: widget._minLines,
            maxLines: widget._maxLines,
            style: Theme.of(context).textTheme.displayMedium,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              counterStyle: Theme.of(context).textTheme.headlineSmall,
              hintText: widget._hintText,
              filled: true,
              fillColor: isDark ? UiCor.bordaEscura : UiCor.borda,
              hintStyle: Theme.of(context).textTheme.bodySmall,
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
