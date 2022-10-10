import 'package:flutter/material.dart';
import 'package:bluuffed_app/widget/resume_widget.dart';
import 'package:bluuffed_app/widget/subtitle_widget.dart';

class PerfilItem extends StatelessWidget {
  const PerfilItem({required String title, required String resume})
      : _title = title,
        _resume = resume;

  final String _title;
  final String _resume;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleWidget(resume: _title),
        ResumeWidget(resume: _resume),
      ],
    );
  }
}
