import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/text/data_text.dart';
import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({
    super.key,
    bool? avatar = true,
    required Map<String, dynamic> item,
  })  : _avatar = avatar,
        _item = item;

  final bool? _avatar;
  final Map<String, dynamic> _item;

  @override
  State<InfoWidget> createState() => _InfoTextState();
}

class _InfoTextState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget._avatar!)
          widget._item['isAnonimo']
              ? const LegendaText(legenda: ANONIMO)
              : Row(
                  children: [
                    AvatarWidget(
                      avatar: widget._item['avatarUsuario'],
                      size: 6,
                    ),
                    const SizedBox(width: 4),
                    LegendaText(legenda: widget._item['nomeUsuario'])
                  ],
                ),
        if (widget._avatar!) const LegendaText(legenda: ' · '),
        DataText(item: widget._item),
        if (widget._item['isEditado'])
          const LegendaText(legenda: ' · $EDITADO'),
        if (widget._item['isAutorizado']) const LegendaText(legenda: ' · '),
        if (widget._item['isAutorizado']) SvgPicture.asset(UiSvg.autorizado),
      ],
    );
  }
}
