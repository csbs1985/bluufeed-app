import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:bluuffed_app/widget/toggle_widget.dart';
import 'package:flutter/material.dart';

class SelectToggleWidget extends StatefulWidget {
  const SelectToggleWidget({
    required Function callback,
    required String title,
    required String resume,
    required bool value,
  })  : _title = title,
        _resume = resume,
        _callback = callback,
        _value = value;

  final Function _callback;
  final String _title;
  final String _resume;
  final bool _value;

  @override
  State<SelectToggleWidget> createState() => _SelectToggleWidgetState();
}

class _SelectToggleWidgetState extends State<SelectToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget._callback(true),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(UiPadding.large),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorder.none),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 108,
            child: SubtitleResumeWidget(
              title: widget._title,
              resume: widget._resume,
            ),
          ),
          ToggleWidget(
            value: widget._value,
            callback: (value) => widget._callback(value),
          ),
        ],
      ),
    );
  }
}
