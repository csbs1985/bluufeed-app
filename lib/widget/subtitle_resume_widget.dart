import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/widget/resume_widget.dart';
import 'package:universe_history_app/widget/subtitle_widget.dart';

class SubtitleResumeWidget extends StatelessWidget {
  const SubtitleResumeWidget({required String title, required String resume})
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
