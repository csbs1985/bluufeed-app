import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/text/data_text.dart';
import 'package:eight_app/text/legenda_text.dart';
import 'package:eight_app/theme/ui_svg.dart';
import 'package:eight_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoriaInfoWidget extends StatefulWidget {
  const HistoriaInfoWidget({
    super.key,
    required Map<String, dynamic> item,
    bool? isAvatar = true,
  })  : _item = item,
        _isAvatar = isAvatar;

  final Map<String, dynamic> _item;
  final bool? _isAvatar;

  @override
  State<HistoriaInfoWidget> createState() => _InfoTextState();
}

class _InfoTextState extends State<HistoriaInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget._isAvatar == true)
          Row(
            children: [
              AvatarWidget(
                avatar: widget._item['avatarUsuario'],
                size: 6,
              ),
              const SizedBox(width: 4),
              LegendaText(legenda: widget._item['nomeUsuario']),
              const LegendaText(legenda: ' · '),
            ],
          ),
        DataText(item: widget._item),
        if (widget._item['isEditado'])
          const LegendaText(legenda: ' · $EDITADO'),
        if (widget._item['isAutorizado']) const LegendaText(legenda: ' · '),
        if (widget._item['isAutorizado']) SvgPicture.asset(UiSvg.autorizado),
      ],
    );
  }
}
