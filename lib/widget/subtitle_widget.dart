import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_text.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    required String resume,
  }) : _resume = resume;

  final String _resume;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        _resume,
        style: UiText.subtitle,
      ),
    );
  }
}
