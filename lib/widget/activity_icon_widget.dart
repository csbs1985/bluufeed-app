import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:flutter/material.dart';

class ActivityIconWidget extends StatefulWidget {
  const ActivityIconWidget({
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  @override
  _ActivityIconWidgetState createState() => _ActivityIconWidgetState();
}

class _ActivityIconWidgetState extends State<ActivityIconWidget> {
  Color _getColor() {
    if (widget._item['type'] == ActivityEnum.LOGIN.value) return UiColor.login;
    return Colors.indigo;
  }

  String _getLetter() {
    return 'L';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      child: Container(
        width: UiSize.iconCircleLarge,
        height: UiSize.iconCircleLarge,
        color: _getColor(),
        alignment: Alignment.center,
        child: Text(
          _getLetter(),
          style: UiText.icon,
        ),
      ),
    );
  }
}
