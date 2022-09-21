import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:flutter/material.dart';

class IconActivityWidget extends StatefulWidget {
  const IconActivityWidget({
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  @override
  _IconCicleWidgetState createState() => _IconCicleWidgetState();
}

class _IconCicleWidgetState extends State<IconActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiBorder.circle),
      child: Container(
        width: UiSize.iconCircle,
        height: UiSize.iconCircle,
        color: Colors.amber,
        alignment: Alignment.center,
        child: const Text(
          'L',
          style: UiText.icon,
        ),
      ),
    );
  }
}
