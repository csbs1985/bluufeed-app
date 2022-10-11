import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/widget/text_widget.dart';

class ButtonLinkWidget extends StatefulWidget {
  const ButtonLinkWidget({
    required String label,
    required String link,
  })  : _label = label,
        _link = link;

  final String _label;
  final String _link;

  @override
  State<ButtonLinkWidget> createState() => _ButtonLinkWidgetState();
}

class _ButtonLinkWidgetState extends State<ButtonLinkWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(widget._link),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorder.none),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Headline2(text: widget._label),
        ),
      ),
    );
  }
}
