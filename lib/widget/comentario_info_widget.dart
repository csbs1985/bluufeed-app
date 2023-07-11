import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/text/data_text.dart';
import 'package:eight_app/text/legenda_text.dart';
import 'package:eight_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';

class ComentarioInfoWidget extends StatefulWidget {
  const ComentarioInfoWidget({
    super.key,
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  @override
  State<ComentarioInfoWidget> createState() => _InfoTextState();
}

class _InfoTextState extends State<ComentarioInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (currentUsuario.value.idUsuario != widget._item['idUsuario'])
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
      ],
    );
  }
}
