import 'package:flutter/material.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AlertConfirmComponent extends StatefulWidget {
  const AlertConfirmComponent({
    required Function callback,
    required String title,
    required String text,
    String? link,
    String? btnPrimaryLabel,
    String? btnSecondaryLabel,
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel;

  final Function _callback;

  final String _title;
  final String _text;
  final String? _btnPrimaryLabel;
  final String? _btnSecondaryLabel;

  @override
  State<AlertConfirmComponent> createState() => _AlertConfirmComponentState();
}

class _AlertConfirmComponentState extends State<AlertConfirmComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actionsPadding: const EdgeInsets.fromLTRB(10, 20, 10, 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      backgroundColor: UiColor.comp_1,
      title: Text(
        widget._title,
        style: UiTextStyle.header2,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              widget._text,
              style: UiTextStyle.text1,
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button3dComponent(
              label: widget._btnSecondaryLabel!,
              size: ButtonSizeEnum.MEDIUM.name,
              style: ButtonStyleEnum.SECOND.name,
              callback: (value) => widget._callback(true),
            ),
            Button3dComponent(
              label: widget._btnPrimaryLabel!,
              size: ButtonSizeEnum.MEDIUM.name,
              style: ButtonStyleEnum.PRIMARY.name,
              callback: (value) => widget._callback(false),
            ),
          ],
        ),
      ],
    );
  }
}
