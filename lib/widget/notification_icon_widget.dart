import 'package:bluuffed_app/model/notification_model.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationIconWidget extends StatefulWidget {
  const NotificationIconWidget({
    required String item,
  }) : _item = item;

  final String _item;

  @override
  _NotificationIconWidgetState createState() => _NotificationIconWidgetState();
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      child: Container(
        width: UiSize.iconCircleLarge,
        height: UiSize.iconCircleLarge,
        color: UiColor.tertiary,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          widget._item == NotificationEnum.SEND_HISTORY.value
              ? UiIcon.send
              : UiIcon.comment,
          color: Colors.white,
          height: UiSize.iconSmall,
        ),
      ),
    );
  }
}
