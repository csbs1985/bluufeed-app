import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SinceWidget extends StatelessWidget {
  const SinceWidget({required String date}) : _date = date;

  final String _date;

  String _getSince() {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(_date).millisecondsSinceEpoch);
    var day = DateFormat('dd');
    var month = DateFormat('M');
    var year = DateFormat('yyyy');
    var time = '';
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

    return time = day.format(date) +
        ' de ' +
        months[int.parse(month.format(date)) - 1] +
        ' de ' +
        year.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return TextWidget(text: _getSince());
  }
}
