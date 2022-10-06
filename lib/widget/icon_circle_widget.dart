import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:flutter/material.dart';

class IconCicleWidget extends StatefulWidget {
  const IconCicleWidget({
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  @override
  _IconCicleWidgetState createState() => _IconCicleWidgetState();
}

class _IconCicleWidgetState extends State<IconCicleWidget> {
  Color _getColor() {
    if (widget._item['type'] == ActivityEnum.LOGIN.value) return UiColor.login;
    return Colors.indigo;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiBorder.circle),
      child: Container(
        width: UiSize.iconCircle,
        height: UiSize.iconCircle,
        color: _getColor(),
        alignment: Alignment.center,
        child: const Text(
          'L',
          style: UiText.icon,
        ),
      ),
    );
  }
}
