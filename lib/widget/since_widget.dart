import 'package:bluuffed_app/widget/subtitle_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SinceWidget extends StatelessWidget {
  const SinceWidget({required String date}) : _date = date;

  final String _date;

  String _getSince() {
    var date = DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(_date).millisecondsSinceEpoch);
    var day = DateFormat('dd');
    var month = DateFormat('M');
    var year = DateFormat('yyyy');
    var months = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezsembro'
    ];

    return day.format(date) +
        ' de ' +
        months[int.parse(month.format(date)) - 1] +
        ' de ' +
        year.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubtitleWidget(resume: 'desde'),
        TextWidget(text: _getSince()),
      ],
    );
  }
}
