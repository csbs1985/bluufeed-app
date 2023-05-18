import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconeButton extends StatefulWidget {
  const IconeButton({
    super.key,
    required Function callback,
    required String icone,
    Color? cor,
    String? texto = "",
  })  : _callback = callback,
        _cor = cor,
        _texto = texto,
        _icone = icone;

  final Function _callback;
  final String _icone;
  final String? _texto;
  final Color? _cor;

  @override
  State<IconeButton> createState() => _IconeButtonState();
}

class _IconeButtonState extends State<IconeButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(UiBorda.circulo),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Builder(builder: (context) {
              return SvgPicture.asset(
                widget._icone,
                color: widget._cor,
              );
            }),
            if (widget._texto != "") const SizedBox(width: 8),
            if (widget._texto != "") LegendaText(legenda: widget._texto!)
          ],
        ),
      ),
      onTap: () => widget._callback(),
    );
  }
}
